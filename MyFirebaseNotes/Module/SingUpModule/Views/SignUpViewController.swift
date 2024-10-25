//
//  SignUpViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

protocol SignUpViewControllerProtocol: AnyObject {
    func showAlert(message: String, success: Bool)
}

final class SignUpViewController: UIViewController, SignUpViewControllerProtocol {
    var presenter: SignUpPresenter!
    
    lazy var signUpLabel = AppUI.createLabel(text: "Регистрация",
                                             color: AppColorSet.SignUp.signUpLabel,
                                             font: AppFontSet.SignUp.signUpLabel, textAlignment: .center)
    
    lazy var signUpView = AppUI.createView(color: AppColorSet.SignUp.signUpView, cornerRadius: 27.52)
    
    lazy var nameLabel = AppUI.createLabel(text: "ИМЯ",
                                           color: AppColorSet.SignUp.textFieldHeader,
                                           font: AppFontSet.SignUp.textFieldHeader)
    lazy var nameTextField = AppUI.createTextField(placeholder: "Александр", 
                                                   color: AppColorSet.SignUp.textFieldText,
                                                   font: AppFontSet.SignUp.textFieldText)
    lazy var nameStack = AppUI.createStack(spacing: 9.52, views: nameLabel, nameTextField)
    
    lazy var emailLabel = AppUI.createLabel(text: "ПОЧТА",
                                           color: AppColorSet.SignUp.textFieldHeader,
                                           font: AppFontSet.SignUp.textFieldHeader)
    lazy var emailTextField = AppUI.createTextField(placeholder: "example@gmail.com",
                                                   color: AppColorSet.SignUp.textFieldText,
                                                   font: AppFontSet.SignUp.textFieldText)
    lazy var emailStack = AppUI.createStack(spacing: 9.52, views: emailLabel, emailTextField)
    
    lazy var passwordLabel = AppUI.createLabel(text: "ПАРОЛЬ",
                                           color: AppColorSet.SignUp.textFieldHeader,
                                           font: AppFontSet.SignUp.textFieldHeader)
    lazy var passwordTextField = AppUI.createTextField(placeholder: "1234",
                                                   color: AppColorSet.SignUp.textFieldText,
                                                   font: AppFontSet.SignUp.textFieldText, isSecureTextEntry: true)
    lazy var passwordStack = AppUI.createStack(spacing: 9.52, views: passwordLabel, passwordTextField)
    
    lazy var textFieldStack = AppUI.createStack(spacing: 27.52, views: nameStack, emailStack, passwordStack)
    
    lazy var checkMarkButton = AppUI.createCheckmark(btn: signUpButton)
    
    lazy var agreementLabel = AppUI.createLabel(text: "Я согласен с Условиями предоставления услуг и Политикой конфиденциальности",
                                                color: AppColorSet.SignUp.agreementLabel,
                                                font: AppFontSet.SignUp.agreementLabel)
    
    lazy var agreementStack = AppUI.createStack(axis: .horizontal, alignment: .center, spacing: 22.93, views: checkMarkButton, agreementLabel)
    
    lazy var signUpButton = AppUI.createAuthButton(title: "РЕГИСТРАЦИЯ",
                                                   color: AppColorSet.SignUp.authButtonTitle,
                                                   font: AppFontSet.SignUp.authButtonTitle,
                                                   bgColor: AppColorSet.SignUp.authButtonView,
                                                   isEnabled: false) {[weak self] _ in
        guard let self else {return}
      
        let userAuth = UserAuth(name: nameTextField.text ?? "",
                                email: emailTextField.text ?? "",
                                password: passwordTextField.text ?? "")
        
        presenter.signUp(userAuth: userAuth)
    }
    
    lazy var additionalQuestionLabel = AppUI.createLabel(text: "Уже есть аккаунт?",
                                                         color: AppColorSet.SignUp.additionalQuestionLabel,
                                                         font: AppFontSet.SignUp.additionalQuestionLabel)
    lazy var authTextButton = AppUI.createAuthTextButton(title: "ВОЙТИ",
                                                         color: AppColorSet.SignUp.authTextButtonTitle,
                                                         font: AppFontSet.SignUp.authTextButtonTitle) { _ in
        NotificationCenter.default.post(name: .setVC, object: nil, userInfo: ["vcType" : VCType.signIn])
    }
    
    lazy var textButtonStack = AppUI.createStack(axis: .horizontal, alignment: .center, spacing: 9.81, views: additionalQuestionLabel, authTextButton)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignUpPresenter(view: self)
        view.addSubview(signUpLabel)
        view.addSubview(signUpView)
        
        [textFieldStack, agreementStack, signUpButton, textButtonStack].forEach {
            signUpView.addSubview($0)
        }
        
        setConstraints()
    }
    
    func showAlert(message: String, success: Bool) {
        if success {
            let alert = UIAlertController(title: "ПОЗДРАВЛЯЕМ", message: message, preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                alert.dismiss(animated: true)
                NotificationCenter.default.post(name: .setVC, object: nil, userInfo: ["vcType" : VCType.tabBar])
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "ОШИБКА", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                alert.dismiss(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}

extension SignUpViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            signUpLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            signUpView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 27.8),
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            
            textFieldStack.centerXAnchor.constraint(equalTo: signUpView.centerXAnchor),
            textFieldStack.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor, constant: 27.52),
            textFieldStack.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor, constant: -27.52),
            textFieldStack.topAnchor.constraint(equalTo: signUpView.topAnchor, constant: 50.45),
            
            agreementStack.centerXAnchor.constraint(equalTo: signUpView.centerXAnchor),
            agreementStack.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor, constant: 27.52),
            agreementStack.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor, constant: -27.52),
            agreementStack.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 27.52),
            
            signUpButton.topAnchor.constraint(equalTo: agreementStack.bottomAnchor, constant: 22.19),
            signUpButton.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor, constant: 27.52),
            signUpButton.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor, constant: -27.52),
            
            textButtonStack.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 28.67),
            textButtonStack.centerXAnchor.constraint(equalTo: signUpView.centerXAnchor)
        ])
    }
}
