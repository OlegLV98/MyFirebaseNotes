//
//  FavoriteModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 13.06.2024.
//

import Foundation

class FavoriteModel {
    let firestore = FirestoreManager.shared
    let authManger = AuthManager.shared
    let storage = StorageManager.shared
    
    static let shared = FavoriteModel()
    private init() {}
    
    func deleteNote(note: Note, completion: @escaping (Error?) -> Void) {
        firestore.updateNote(userId: note.userId ?? "", folderId: note.folderId ?? "", noteId: note.id, data: ["is_favorite": false])  {completion($0)}
    }
    
    func getNotes(completion: @escaping (Result<[Note], Error>) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        firestore.getFavoriteNotes(userId: uid) {result in
            switch result {
            case .success(let notes):
                completion(.success(notes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
