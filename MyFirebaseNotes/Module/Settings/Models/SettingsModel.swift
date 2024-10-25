//
//  SettingsModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 27.06.2024.
//

import Foundation

class SettingsModel {
    static let shared = SettingsModel()
    let firestore = FirestoreManager.shared
    let authManger = AuthManager.shared
    let storage = StorageManager.shared
    private init() {}
    
    func resetPassword(completion: @escaping (Error?) -> Void) {
            guard let authUser = authManger.getAuthUser(), let email = authUser.email else {
                completion(URLError(.fileDoesNotExist))
                return
            }
            authManger.resetPassword(email: email) {completion($0)}
    }
    
    func updatePassword(password: String, completion: @escaping (Error?) -> Void) {
        authManger.updatePassword(password: password) {completion($0)}
    }
    
    func updateEmail(email: String, completion: @escaping (Error?) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(URLError(.badServerResponse))
            return
        }
        authManger.updateEmail(email: email) {[weak self] error in
            if let error = error {
                completion(error)
            } else {
                self?.firestore.updateData(userId: uid, data: ["email": email]) {completion($0)}
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
    
    func deleteUserData(userId: String, completion: @escaping (Error?) -> Void) {
        firestore.getUserData(userId: userId) {[weak self] result in
            switch result {
            case .success(let user):
                guard let path = user.profileImagePath else {
                    self?.firestore.deleteAccount(userId: userId) { [weak self]error in
                        if let error = error {
                            completion(error)
                        } else {
                            self?.authManger.deleteAccount {completion($0)}
                        }
                    }
                    return
                }
                self?.storage.deleteProfileImage(userId: userId, path: path) {[weak self] error in
                    if let error = error {
                        completion(error)
                    } else {
                        self?.firestore.deleteAccount(userId: userId) { [weak self]error in
                            if let error = error {
                                completion(error)
                            } else {
                                self?.authManger.deleteAccount {completion($0)}
                            }
                        }
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func deleteAccount(completion: @escaping (Error?) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion((URLError(.badServerResponse)))
            return
        }
        firestore.getFoldersIds(userId: uid) {[weak self] result in
            guard let self else {return}
            var fileErrors: [Error?] = []
            let dispathcGroup = DispatchGroup()
            switch result {
            case .success(let ids):
                if ids.isEmpty {
                    deleteUserData(userId: uid) {completion($0)}
                    return
                }
                for id in ids {
                    dispathcGroup.enter()
                    deleteFolder(folderId: id) {error in
                        if let error = error {
                            fileErrors.append(error)
                        }
                        dispathcGroup.leave()
                    }
                }
                dispathcGroup.notify(queue: .main) { [weak self] in
                    self?.deleteUserData(userId: uid) {completion($0)}
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func signOut() {
        authManger.signOut()
    }
}
