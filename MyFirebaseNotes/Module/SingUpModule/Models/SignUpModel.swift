//
//  SignUpModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
final class SignUpModel {
    static let shared = SignUpModel()
    let authManger = AuthManager.shared
    private init() {}
    
    func signUp(userAuth: UserAuth, completion: @escaping (Result<UserData, Error>) -> Void) {
        guard !userAuth.email.isEmpty, !userAuth.password.isEmpty else {
            completion(.failure(AuthError.emptyEmailOrPassword))
            return
        }
        authManger.createUser(userAuth: userAuth) {completion($0)}
    }
}

