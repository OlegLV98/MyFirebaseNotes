//
//  SettingsPresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 27.06.2024.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewControllerProtocol, model: SettingsModel)
    func signOut()
    func resetPassword()
    func updatePassword(password: String)
    func updateEmail(email: String)
    func deleteAccount()
}

class SettingsPresenter: SettingsPresenterProtocol {
    let settingsModel: SettingsModel!
    weak var view: SettingsViewControllerProtocol?
    
    required init(view: SettingsViewControllerProtocol, model: SettingsModel) {
        self.view = view
        self.settingsModel = model
    }
    
    func showAlert(_ error: Error?, msg: String) {
        if let error = error {
            DispatchQueue.main.async {[weak self] in
                guard let self, let view else { return }
                view.showAlert(message: error.localizedDescription, success: false)
            }
        } else {
            DispatchQueue.main.async {[weak self] in
                guard let self, let view else { return }
                view.showAlert(message: msg, success: true)
            }
        }
    }
    
    func deleteAccount() {
        settingsModel.deleteAccount {[weak self] error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.signOut()
            }
        }
    }
    
    func resetPassword() {
        settingsModel.resetPassword() { [weak self] error in
            guard let self else { return }
            showAlert(error, msg: "Ваш пароль успешно сброшен! Вам было отправлено письмо, в котором Вы можете задать новый пароль!")
        }
    }
    
    func updatePassword(password: String) {
        if password.isEmpty {
            view?.showAlert()
            return
        }
        settingsModel.updatePassword(password: password) { [weak self] error in
            guard let self else { return }
            showAlert(error, msg: "Ваш пароль успешно изменён!")
        }
    }
    
    func updateEmail(email: String) {
        if email.isEmpty {
            view?.showAlert()
            return
        }
        settingsModel.updateEmail(email: email) { [weak self] error in
            guard let self else { return }
            showAlert(error, msg: "Проверьте почту, Вам было отправлено письмо на новый email!")
        }
    }
    
    func signOut() {
        settingsModel.signOut()
        NotificationCenter.default.post(name: .setVC, object: nil, userInfo: ["vcType" : VCType.signIn])
    }
}
