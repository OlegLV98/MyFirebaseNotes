//
//  CreatingModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 01.07.2024.
//

import Foundation
import Firebase
import FirebaseStorage

class CreatingModel {
    static let shared = CreatingModel()
    private init() {}
    let firestore = FirestoreManager.shared
    let authManger = AuthManager.shared
    let storage = StorageManager.shared
    
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    func addNote(title: String?, text: String?, imageData: Data?, folderId: String, completion: @escaping (Error?) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(URLError(.badServerResponse))
            return
        }
    
        let note = Note(userId: uid, folderId: folderId, title: title, text: text)
        firestore.addNote(note: note, userId: uid) { [weak self] error in
            if let error = error {
                completion(error)
            } else {
                guard let data = imageData else {
                    completion(nil)
                    return
                }
                self?.saveNoteImage(image: data, userId: uid, folderId: folderId, noteId: note.id) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func saveNoteImage(image: Data, userId: String, folderId: String, noteId: String, completion: @escaping (Error?) -> Void) {
        let path = UUID().uuidString + ".jpeg"
        let updatedData = [ "note_image_path": path ]
        firestore.updateNote(userId: userId, folderId: folderId, noteId: noteId, data: updatedData) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        storage.saveNoteImage(image: image, userId: userId, folderId: folderId, noteId: noteId, path: path) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let url):
                let updatedData = [ "image_url": url]
                firestore.updateNote(userId: userId, folderId: folderId, noteId: noteId, data: updatedData) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
}
