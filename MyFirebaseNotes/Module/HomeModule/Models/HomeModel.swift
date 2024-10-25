//
//  HomeModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 13.06.2024.
//

import Foundation

class HomeModel {
    
    static let shared = HomeModel()
    private init() {}
    let firestore = FirestoreManager.shared
    let authManger = AuthManager.shared
    let storage = StorageManager.shared
    
    func addFolder(name: String, completion: @escaping (Result<Folder, Error>) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        let folder = Folder(userId: uid, name: name)
        firestore.addFolder(folder: folder, userId: uid) { result in
            switch result {
            case .success(let folder):
                completion(.success(folder))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteFolder(folderId: String, completion: @escaping (Error?) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(URLError(.badServerResponse))
            return
        }
        firestore.deleteFolder(userId: uid, folderId: folderId) { [weak self]result in
            guard let self else {return}
            switch result {
            case .success(let pathsIds):
                let dispathcGroup = DispatchGroup()
                var fileErrors: [Error?] = []
                for pathId in pathsIds {
                    dispathcGroup.enter()
                    
                    storage.deleteNoteImage(userId: uid, folderId: folderId, noteId: pathId.1, path: pathId.0) { error in
                        if let error = error {
                            fileErrors.append(error)
                        }
                    }
                    dispathcGroup.leave()
                }
                dispathcGroup.notify(queue: .main) {
                    if !fileErrors.isEmpty {
                        completion(fileErrors[0])
                    } else {
                        completion(nil)
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getFolders(completion: @escaping (Result<[Folder], Error>) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        firestore.getFolders(userId: uid) { result in
            switch result {
            case .success(let folders):
                completion(.success(folders))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct Folder: Identifiable {
    var id: String = UUID().uuidString
    var userId: String
    var name: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["user_id"] = userId
        repres["name"] = name
        return repres
    }
}
