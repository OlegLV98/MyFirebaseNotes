//
//  AuthManager.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 27.06.2024.
//

import Foundation
import FirebaseAuth
class AuthManager {
    
    static let shared = AuthManager()
    
    let auth = Auth.auth()
    
    func getAuthUser() -> User? {
        return auth.currentUser
    }
    
    private init() {}
    
    func createUser(userAuth: UserAuth, completion: @escaping (Result<UserData, Error>) -> Void) {
        auth.createUser(withEmail: userAuth.email, password: userAuth.password) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let authDataResult = result else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            var userData = UserData(user: authDataResult.user)
            userData.name = userAuth.name
            FirestoreManager.shared.createUser(user: userData)
            completion(.success(userData))
        }
    }
    
    func signIn(user: UserAuth, completion: @escaping (Result<UserData, Error>) -> Void) {
        auth.signIn(withEmail: user.email, password: user.password) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let authDataResult = result else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            completion(.success(UserData(user: authDataResult.user)))
        }
    }
    
    func deleteAccount(completion: @escaping (Error?) -> Void) {
        guard let user = auth.currentUser else {
            completion(URLError(.badServerResponse))
            return
        }
        user.delete {completion($0)}
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(error)
            }
            completion(nil)
        }
    }
    
    func updatePassword(password: String, completion: @escaping (Error?) -> Void) {
        guard let user = auth.currentUser else {
            completion(URLError(.badServerResponse))
            return
        }
        user.updatePassword(to: password)
        completion(nil)
    }
    
    func updateEmail(email: String, completion: @escaping (Error?) -> Void) {
        guard let user = auth.currentUser else {
            completion(URLError(.badServerResponse))
            return
        }
        user.sendEmailVerification(beforeUpdatingEmail: email)
        completion(nil)
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

enum AuthError: Error {
    case emptyEmailOrPassword
}

struct UserAuth {
    var name: String
    var email: String
    var password: String
}


struct UserData {
    var uid: String? = nil
    var name: String? = nil
    var email: String? = nil
    var isAnonymous: Bool = false
    var phone: String? = nil
    var dateOfBirth: String? = nil
    var address: String? = nil
    var photoUrl: String? = nil
    var profileImagePath: String? = nil
    init() {}
    
    init(user: User) {
        uid = user.uid
        email = user.email
        photoUrl = user.photoURL?.absoluteString
        isAnonymous = user.isAnonymous
    }
    
    var data: [String: Any] {
       return [
            "uid": uid ?? "",
            "name": name ?? "",
            "email": email ?? "",
            "address": address ?? "",
            "photo_url": photoUrl ?? "",
            "phone": phone ?? "",
            "is_anonymoususer": isAnonymous,
            "date_of_birth": dateOfBirth ?? "",
            "profile_image_path" : profileImagePath ?? ""
        ]
    }
}
