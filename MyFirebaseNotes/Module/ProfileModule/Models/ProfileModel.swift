//
//  ProfileModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import Foundation
import Firebase
import FirebaseStorage
final class ProfileModel {
    static let shared = ProfileModel()
    let firestore = FirestoreManager.shared
    let authManger = AuthManager.shared
    let storage = StorageManager.shared
    private init() {}
    
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    func saveProfileImage(image: Data, completion: @escaping (Error?) -> Void) {
        let path = UUID().uuidString + ".jpeg"
        let updatedData = [ "profile_image_path": path ]
        firestore.updateData(userId: currentUser?.uid ?? "", data: updatedData) {[weak self] error in
            guard let self else {return}
            if let error = error {
                completion(error)
            } else {
                storage.saveImage(image: image, userId: authManger.auth.currentUser?.uid ?? "", path: path) { [weak self] result in
                    switch result {
                    case .success(let url):
                        let updatedData = [ "photo_url": url.absoluteString]
                        self?.firestore.updateData(userId: self?.currentUser?.uid ?? "", data: updatedData) {completion($0)}
                    case .failure(let error):
                        completion(error)
                    }
                }
            }
        }
    }
    
    
    func getUserData(completion: @escaping (Result<UserData, Error>) -> Void) {
        firestore.getUserData(userId: currentUser?.uid ?? "") {completion($0)}
    }
    
    func updateUserData(data: [String: Any], completion: @escaping (Error?) -> Void) {
        guard let uid = currentUser?.uid else {return}
        firestore.updateData(userId: uid, data: data) {completion($0)}
    }
    
    func signOut() {
        authManger.signOut()
    }
}
