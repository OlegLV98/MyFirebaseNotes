//
//  SettingsViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 27.06.2024.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {
    func showAlert(message: String, success: Bool)
    func showAlert()
}

class SettingsViewController: UIViewController, SettingsViewControllerProtocol {
    var presenter: SettingsPresenterProtocol!
    lazy var resetPassword = AppUI.createButton(text: "Сбросить пароль") { [weak self]_ in
        guard let self else { return }
        presenter.resetPassword()
    }
    
    lazy var deleteAccount = AppUI.createButton(text: "Удалить аккаунт",
                                                textColor: AppColorSet.Settings.deleteText,
                                                borderColor: AppColorSet.Settings.deleteButton.cgColor) { [weak self]_ in
        guard let self else { return }
        presenter.deleteAccount()
    }
    
    lazy var updatePassword = AppUI.createButton(text: "Обновить пароль") { [weak self]_ in
        guard let self else { return }
        let alert = UIAlertController(title: "Новый пароль", message: "Введите пароль", preferredStyle: .alert)
        alert.addTextField()
        let action = UIAlertAction(title: "OK", style: .default) { [weak self]_ in
            guard let self else {return}
            guard let password = alert.textFields?.first?.text else {return}
            alert.dismiss(animated: true)
            presenter.updatePassword(password: password)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Вы ничего не ввели!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) {_ in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    lazy var updateEmail = AppUI.createButton(text: "Обновить email") { [weak self]_ in
        guard let self else { return }
        let alert = UIAlertController(title: "Новый email", message: "Введите новый email!", preferredStyle: .alert)
        alert.addTextField()
        let action = UIAlertAction(title: "OK", style: .default) { [weak self]_ in
            guard let self else {return}
            guard let email = alert.textFields?.first?.text else {return}
            alert.dismiss(animated: true)
            presenter.updateEmail(email: email)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [updateEmail, updatePassword, resetPassword, deleteAccount])
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColorSet.Profile.bgMainView
        view.addSubview(hStack)
        setConstraints()
    }
    
    func showAlert(message: String, success: Bool) {
        if success {
            let alert = UIAlertController(title: "ПОЗДРАВЛЯЕМ", message: message, preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "OK", style: .default) { [weak self]_ in
                guard let self else {return}
                alert.dismiss(animated: true)
                presenter.signOut()
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "ОШИБКА", message: message, preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                alert.dismiss(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}

extension SettingsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
