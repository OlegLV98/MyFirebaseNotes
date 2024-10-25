//
//  SignInViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

protocol SignInViewControllerProtocol: AnyObject {
    func showAlert(message: String, success: Bool, style: UIAlertController.Style)
}

final class SignInViewController: UIViewController, SignInViewControllerProtocol {
    var presenter: SignInPresenter!
    
    lazy var signInLabel = AppUI.createLabel(text: "Войти",
                                             color: AppColorSet.SignIn.signInLabel,
                                             font: AppFontSet.SignIn.signInLabel, textAlignment: .center)
    
    lazy var signInView = AppUI.createView(color: AppColorSet.SignIn.signInView, cornerRadius: 27.52)
    
    lazy var emailLabel = AppUI.createLabel(text: "ПОЧТА",
                                           color: AppColorSet.SignIn.textFieldHeader,
                                           font: AppFontSet.SignIn.textFieldHeader)
    lazy var emailTextField = AppUI.createTextField(placeholder: "example@gmail.com",
                                                   color: AppColorSet.SignIn.textFieldText,
                                                   font: AppFontSet.SignIn.textFieldText)
    lazy var emailStack = AppUI.createStack(spacing: 9.52, views: emailLabel, emailTextField)
    
    lazy var passwordLabel = AppUI.createLabel(text: "ПАРОЛЬ",
                                           color: AppColorSet.SignIn.textFieldHeader,
                                           font: AppFontSet.SignIn.textFieldHeader)
    lazy var passwordTextField = AppUI.createTextField(placeholder: "1234",
                                                   color: AppColorSet.SignIn.textFieldText,
                                                   font: AppFontSet.SignIn.textFieldText, isSecureTextEntry: true)
    lazy var passwordStack = AppUI.createStack(spacing: 9.52, views: passwordLabel, passwordTextField)
    
    lazy var textFieldStack = AppUI.createStack(spacing: 27.52, views: emailStack, passwordStack)
    
    lazy var passwordResetButton: UIButton = {
        let button = UIButton(primaryAction: UIAction {[weak self] action in
            guard let self else { return }
            guard let email = emailTextField.text, !email.isEmpty else {
                showAlert(message: "Введите свой email", success: false)
                return
            }
            presenter.resetPassword(email: email)
        })
        button.setTitleColor(AppColorSet.SignIn.passwordResetButton, for: .normal)
        let attributedTitle = NSAttributedString(string: "Сбросить пароль",
                                                 attributes: [.font: AppFontSet.SignIn.passwordResetButton,
                                                              .foregroundColor: AppColorSet.SignIn.passwordResetButton])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func showAlert(message: String, success: Bool, style: UIAlertController.Style = .actionSheet) {
        if success {
            let alert = UIAlertController(title: "ПОЗДРАВЛЯЕМ", message: message, preferredStyle: style)
            let action = UIAlertAction(title: "OK", style: .default) { [weak self]_ in
                guard let self else {return}
                alert.dismiss(animated: true)
                presenter.signOut()
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "ОШИБКА", message: message, preferredStyle: style)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                alert.dismiss(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    lazy var signInButton = AppUI.createAuthButton(title: "ВОЙТИ",
                                                   color: AppColorSet.SignIn.authButtonTitle,
                                                   font: AppFontSet.SignIn.authButtonTitle,
                                                   bgColor: AppColorSet.SignIn.authButtonView) { [weak self] _ in
        guard let self else { return }
        
        let user = UserAuth(name: "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        self.presenter.signIn(user: user)
    }
    
    lazy var additionalQuestionLabel = AppUI.createLabel(text: "У вас нет аккаунта?",
                                                         color: AppColorSet.SignIn.additionalQuestionLabel,
                                                         font: AppFontSet.SignIn.additionalQuestionLabel)
    lazy var authTextButton = AppUI.createAuthTextButton(title: "РЕГИСТРАЦИЯ",
                                                         color: AppColorSet.SignIn.authTextButtonTitle,
                                                         font: AppFontSet.SignIn.authTextButtonTitle) { _ in
        NotificationCenter.default.post(name: .setVC, object: nil, userInfo: ["vcType" : VCType.signUp])
    }
    
    lazy var textButtonStack = AppUI.createStack(axis: .horizontal, alignment: .center, spacing: 9.81, views: additionalQuestionLabel, authTextButton)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignInPresenter(view: self)
        view.addSubview(signInLabel)
        view.addSubview(signInView)
        view.addSubview(passwordResetButton)
        [textFieldStack, signInButton, textButtonStack].forEach {
            signInView.addSubview($0)
        }
        
        setConstraints()
    }
}

extension SignInViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            signInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            signInView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 27.8),
            signInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            
            textFieldStack.centerXAnchor.constraint(equalTo: signInView.centerXAnchor),
            textFieldStack.leadingAnchor.constraint(equalTo: signInView.leadingAnchor, constant: 27.52),
            textFieldStack.trailingAnchor.constraint(equalTo: signInView.trailingAnchor, constant: -27.52),
            textFieldStack.topAnchor.constraint(equalTo: signInView.topAnchor, constant: 50.45),
            
            passwordResetButton.centerXAnchor.constraint(equalTo: signInView.centerXAnchor),
            passwordResetButton.leadingAnchor.constraint(equalTo: signInView.leadingAnchor, constant: 27.52),
            passwordResetButton.trailingAnchor.constraint(equalTo: signInView.trailingAnchor, constant: -27.52),
            passwordResetButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 10),
            
            signInButton.topAnchor.constraint(equalTo: passwordResetButton.bottomAnchor, constant: 59.71),
            signInButton.leadingAnchor.constraint(equalTo: signInView.leadingAnchor, constant: 27.52),
            signInButton.trailingAnchor.constraint(equalTo: signInView.trailingAnchor, constant: -27.52),
            
            textButtonStack.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 28.67),
            textButtonStack.centerXAnchor.constraint(equalTo: signInView.centerXAnchor)
        ])
    }
}
