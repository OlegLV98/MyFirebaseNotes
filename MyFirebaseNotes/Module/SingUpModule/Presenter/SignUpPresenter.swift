//
//  SignUpPresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

protocol SignUpPresenterProtocol: AnyObject {
    init(view: SignUpViewControllerProtocol)
    func signUp(userAuth: UserAuth)
}

final class SignUpPresenter: SignUpPresenterProtocol {
    
    lazy var signUpModel = SignUpModel.shared
    
    weak var view: SignUpViewControllerProtocol?
    
    required init(view: SignUpViewControllerProtocol) {
        self.view = view
    }
    
    func signUp(userAuth: UserAuth) {
            signUpModel.signUp(userAuth: userAuth) {result in
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {[weak self] in
                        guard let self, let view else { return }
                        view.showAlert(message: "Вы успешно зарегистрировались с email: \(user.email ?? "")", success: true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {[weak self] in
                        guard let self, let view else { return }
                        view.showAlert(message: error.localizedDescription, success: false)
                    }
                }
            }
        }
}
