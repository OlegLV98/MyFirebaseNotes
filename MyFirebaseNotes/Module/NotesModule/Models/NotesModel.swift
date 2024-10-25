//
//  NotesModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 29.06.2024.
//

import Foundation

class NotesModel {
    
    static var shared = NotesModel()
    private init() {}
    let firestore = FirestoreManager.shared
    let authManger = AuthManager.shared
    let storage = StorageManager.shared
    
    func getNotes(folderId: String, completion: @escaping (Result<[Note], Error>) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        firestore.getNotes(userId: uid, folderId: folderId) {result in
            switch result {
            case .success(let notes):
                completion(.success(notes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addToFavorite(note: Note, completion: @escaping (Error?) -> Void) {
        firestore.updateNote(userId: note.userId ?? "",
                             folderId: note.folderId ?? "",
                             noteId: note.id,
                             data: ["is_favorite": true]) {completion($0)}
    }
    
    func deleteNote(note: Note, completion: @escaping (Error?) -> Void) {
        guard let uid = authManger.getAuthUser()?.uid else {
            completion(URLError(.badServerResponse))
            return
        }
        firestore.deleteNote(userId: uid, folderId: note.folderId ?? "", noteId: note.id) { [weak self]result in
            guard let self else {return}
            switch result {
            case .success(_):
                storage.deleteNoteImage(userId: uid, folderId: note.folderId ?? "", noteId: note.id, path: note.imagePath ?? "") {error in
                    if let error = error {
                        completion(error)
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
        
        
    }
}

struct Note: Identifiable {
    var id = UUID().uuidString
    var userId: String?
    var folderId: String?
    var title: String?
    var text: String?
    var imageURL: String? = ""
    var imagePath: String? = ""
    var isFavorite: Bool = false
    var creationDate: Date?
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["user_id"] = userId
        repres["folder_id"] = folderId
        repres["title"] = title
        repres["text"] = text
        repres["image_url"] = imageURL
        repres["note_image_path"] = imagePath
        repres["is_favorite"] = isFavorite
        repres["creation_date"] = creationDate
        return repres
    }
}
