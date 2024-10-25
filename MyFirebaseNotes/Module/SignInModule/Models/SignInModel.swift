//
//  SignInModel.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import Foundation
import FirebaseAuth

final class SignInModel {
    static let shared = SignInModel()
    
    private init() {}
    
    let authManger = AuthManager.shared
    
    func signIn(userAuth: UserAuth, completion: @escaping (Result<UserData, Error>) -> Void) {
        guard !userAuth.email.isEmpty, !userAuth.password.isEmpty else {
            completion(.failure(AuthError.emptyEmailOrPassword))
            return
        }
        authManger.signIn(user: userAuth) {completion($0)}
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
            authManger.resetPassword(email: email) {completion($0)}
    }
}



