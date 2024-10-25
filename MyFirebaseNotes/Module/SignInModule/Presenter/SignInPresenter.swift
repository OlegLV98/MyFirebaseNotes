//
//  SignInPresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

protocol SignInPresenterProtocol: AnyObject {
    init(view: SignInViewControllerProtocol)
    func resetPassword(email: String)
    func signOut()
}

final class SignInPresenter: SignInPresenterProtocol {
    
    lazy var signInModel = SignInModel.shared
    
    weak var view: SignInViewControllerProtocol?
    
    required init(view: SignInViewControllerProtocol) {
        self.view = view
    }
    
    func signIn(user: UserAuth) {
        signInModel.signIn(userAuth: user) {result in
            switch result {
            case .success(_): NotificationCenter.default.post(name: .setVC, object: nil, userInfo: ["vcType" : VCType.tabBar])
            case .failure(let error):
                DispatchQueue.main.async {[weak self] in
                    guard let self, let view else { return }
                    view.showAlert(message: error.localizedDescription, success: false, style: .alert)
                }
            }
        }
    }
    
    func resetPassword(email: String) {
        signInModel.resetPassword(email: email) { [weak self] error in
            guard let self else { return }
            showAlert(error, msg: "Ваш пароль успешно сброшен! Вам было отправлено письмо, в котором Вы можете задать новый пароль!")
        }
    }
    
    func showAlert(_ error: Error?, msg: String) {
        if let error = error {
            DispatchQueue.main.async {[weak self] in
                guard let self, let view else { return }
                view.showAlert(message: error.localizedDescription, success: false, style: .actionSheet)
            }
        } else {
            DispatchQueue.main.async {[weak self] in
                guard let self, let view else { return }
                view.showAlert(message: msg, success: true, style: .actionSheet)
            }
        }
    }
    
    func signOut() {
        
    }
}
