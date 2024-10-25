//
//  FirestoreManager.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 27.06.2024.
//

import Foundation
import FirebaseFirestore
class FirestoreManager {
    
    static var shared = FirestoreManager()
    private init() {}
    
    let firestore = Firestore.firestore()
    
    func addFolder(folder: Folder, userId: String, completion: @escaping (Result<Folder, Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").document(folder.id).setData(folder.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(folder))
            }
        }
    }
    
    func addNote(note: Note, userId: String, completion: @escaping (Error?) -> Void) {
        firestore
            .collection("users")
            .document(userId)
            .collection("folders")
            .document(note.folderId ?? "")
            .collection("notes")
            .document(note.id)
            .setData(note.representation) {[weak self] error in
                guard let self else {return}
            if let error = error {
                completion(error)
            } else {
                updateNote(userId: userId, folderId: note.folderId ?? "", noteId: note.id, data: ["creation_date": FieldValue.serverTimestamp()]) {completion($0)}
            }
        }
    }
    
    func createUser(user: UserData) {
        firestore
            .collection("users")
            .document(user.uid ?? "")
            .setData(user.data)
    }
    
    func deleteAccount(userId: String, completion: @escaping (Error?) -> Void) {
        firestore.collection("users").document(userId).delete() {completion($0)}
    }
    
    func updateData(userId: String, data: [String : Any], completion: @escaping (Error?) -> Void) {
        firestore
            .collection("users")
            .document(userId)
            .updateData(data) {completion($0)}
    }
    
    func updateNote(userId: String, folderId: String, noteId: String, data: [String : Any], completion: @escaping (Error?) -> Void) {
        firestore
            .collection("users")
            .document(userId)
            .collection("folders")
            .document(folderId)
            .collection("notes")
            .document(noteId)
            .updateData(data) {completion($0)}
    }
    
    func getUserData(userId: String, completion: @escaping (Result<UserData, Error>) -> Void) {
        firestore
            .collection("users")
            .document(userId)
            .getDocument { snapshot, error in
                if let err = error {
                    completion(.failure(err))
                    return
                }
               
                guard let snap = snapshot, let data = snap.data() else {return}
                var userData = UserData()
                userData.uid = data["uid"] as? String
                userData.name = data["name"] as? String
                userData.email = data["email"] as? String
                userData.address = data["address"] as? String
                userData.photoUrl = data["photo_url"] as? String
                userData.phone = data["phone"] as? String
                userData.isAnonymous = data["is_anonymous"] as? Bool ?? false
                userData.dateOfBirth = data["date_of_birth"] as? String
                userData.profileImagePath = data["profile_image_path"] as? String
                completion(.success(userData))
            }
    }
    
    func deleteNote(userId: String, folderId: String, noteId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").document(folderId).collection("notes").document(noteId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func deleteFolder(userId: String, folderId: String, completion: @escaping (Result<[(String, String)], Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").document(folderId).collection("notes").getDocuments {[weak self] snapshot, error in
            guard let self else {return}
            guard let documents = snapshot?.documents else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let batch = firestore.batch()
            var pathsIds: [(String, String)] = []
        
            for document in documents {
                if let path = document.data()["note_image_path"] as? String,
                   let id = document.data()["id"] as? String {
                    pathsIds.append((path, id))
                    let ref = document.reference
                    batch.deleteDocument(ref)
                }
                
            }
            
            batch.commit { [weak self] error in
                guard let self else {return}
                if let error = error {
                    completion(.failure(error))
                } else {
                    firestore.collection("users").document(userId).collection("folders").document(folderId).delete()
                    completion(.success(pathsIds))
                }
            }
        }
    }
    
    func getNotes(userId: String, folderId: String, completion: @escaping (Result<[Note], Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").document(folderId).collection("notes").getDocuments { snapshot, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snap = snapshot else {
                completion(.failure(error!))
                return
            }
            let data = snap.documents
            var notes = [Note]()
            for item in data {
                let data = item.data()
                let note = Note(id: data["id"] as? String ?? "",
                                userId: data["user_id"] as? String ?? "",
                                folderId: data["folder_id"] as? String ?? "",
                                title: data["title"] as? String ?? "",
                                text: data["text"] as? String ?? "",
                                imageURL: data["image_url"] as? String ?? "",
                                imagePath: data["note_image_path"] as? String ?? "",
                                isFavorite: data["is_favorite"] as! Bool,
                                creationDate: (data["creation_date"] as? Timestamp)?.dateValue())
                
                notes.append(note)
            }
            completion(.success(notes))
        }
    }
    
    func getFavoriteNotesInFolder(userId: String, folderId: String, completion: @escaping (Result<[Note], Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").document(folderId).collection("notes").getDocuments { snapshot, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snap = snapshot else {
                completion(.failure(error!))
                return
            }
            let data = snap.documents
            var notes = [Note]()
            for item in data {
                let data = item.data()
                if !(data["is_favorite"] as! Bool) {
                    continue
                }
                let note = Note(id: data["id"] as? String ?? "",
                                userId: data["user_id"] as? String ?? "",
                                folderId: data["folder_id"] as? String ?? "",
                                title: data["title"] as? String ?? "",
                                text: data["text"] as? String ?? "",
                                imageURL: data["image_url"] as? String ?? "",
                                imagePath: data["note_image_path"] as? String ?? "",
                                isFavorite: data["is_favorite"] as! Bool,
                                creationDate: (data["creation_date"] as? Timestamp)?.dateValue())
                
                notes.append(note)
            }
            completion(.success(notes))
        }
    }
    
    func getFavoriteNotes(userId: String, completion: @escaping (Result<[Note], Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").getDocuments {[weak self] snapshot, error in
            guard let self else {return}
            guard let documents = snapshot?.documents else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            let dispatchGroup = DispatchGroup()
            var notes: [Note] = []
            for document in documents {
                dispatchGroup.enter()
                if let folderId  = document.data()["id"] as? String {
                    getFavoriteNotesInFolder(userId: userId, folderId: folderId) { result in
                        defer {
                            dispatchGroup.leave()
                        }
                        switch result {
                        case .failure(let error):
                            completion(.failure(error))
                        case .success(let folderNotes):
                            notes.append(contentsOf: folderNotes)
                        }
                    }
                }
                
            }
            dispatchGroup.notify(queue: .main) {
                completion(.success(notes))
            }
        }
    }
    
    func getFolders(userId: String, completion: @escaping (Result<[Folder], Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snap = snapshot else {
                completion(.failure(error!))
                return
            }
            let data = snap.documents
            var folders = [Folder]()
            
            for item in data {
                let data = item.data()
                let folder = Folder(id: data["id"] as? String ?? "",
                                    userId: data["user_id"] as? String ?? "",
                                    name: data["name"] as? String ?? "")
                folders.append(folder)
            }
            completion(.success(folders))
        }
    }
    
    func getFoldersIds(userId: String, completion: @escaping (Result<[String], Error>) -> Void) {
        firestore.collection("users").document(userId).collection("folders").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snap = snapshot else {
                completion(.failure(error!))
                return
            }
            let data = snap.documents
            var ids = [String]()
            
            for item in data {
                let data = item.data()
                let id = data["id"] as? String ?? ""
                ids.append(id)
            }
            completion(.success(ids))
        }
    }
}
