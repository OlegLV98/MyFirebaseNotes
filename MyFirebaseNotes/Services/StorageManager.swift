//
//  StorageManager.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 27.06.2024.
//

import Foundation
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    private init() {}
    let storageRef = Storage.storage().reference()
    
    private func userReference(userId: String) -> StorageReference {
        storageRef.child("users").child(userId)
    }
    
    private func userFolderReference(userId: String, folderId: String) -> StorageReference {
        storageRef.child("users").child(userId).child("folders").child(folderId)
    }
    
    private func userNoteReference(userId: String, folderId: String, noteId: String) -> StorageReference {
        userReference(userId: userId).child("folders").child(folderId).child("notes").child(noteId)
    }
    
    func saveImage(image: Data, userId: String, path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        userReference(userId: userId).child(path).putData(image, metadata: meta) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(_):
                userReference(userId: userId).child(path).downloadURL { completion($0) }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteProfileImage(userId: String, path: String, completion: @escaping (Error?) -> Void) {
        userReference(userId: userId).child(path).delete {completion($0)}
    }
    
    func saveNoteImage(image: Data, userId: String, folderId: String, noteId: String, path: String, completion: @escaping (Result<String, Error>) -> Void) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        userNoteReference(userId: userId, folderId: folderId, noteId: noteId).child(path).putData(image, metadata: meta) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(_):
                userNoteReference(userId: userId, folderId: folderId, noteId: noteId).child(path).downloadURL { res in
                    switch res {
                    case .success(let url):
                        completion(.success(url.absoluteString))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteNoteImage(userId: String, folderId: String, noteId: String, path: String, completion: @escaping (Error?) -> Void) {
        if path.isEmpty {
            completion(nil)
            return
        }
        userNoteReference(userId: userId, folderId: folderId, noteId: noteId).child(path).delete {error in
            if let error = error {
                completion(error)
            }
        }
    }
}
