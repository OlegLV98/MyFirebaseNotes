//
//  AppUI.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

final class AppUI {
    
    static func createView(color: UIColor?, cornerRadius: CGFloat = 0) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func createLabel(text: String, color: UIColor?, font: UIFont?, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        label.textAlignment = textAlignment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createTextField(placeholder: String, color: UIColor?, font: UIFont?,
                                bgColor: UIColor? = AppColorSet.SignIn.textField,
                                isSecureTextEntry: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = color
        textField.font = font
        textField.backgroundColor = bgColor
        textField.isSecureTextEntry = isSecureTextEntry
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 21.79, height: 1))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44.72, height: 1))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 71.09).isActive = true
        if isSecureTextEntry {
            let button = UIButton()
            button.tintColor = AppColorSet.SignUp.eye
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            button.contentMode = .scaleAspectFill
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            textField.addSubview(button)
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 16.05),
                button.widthAnchor.constraint(equalToConstant: 21.79),
                button.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                button.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -22.93)
            ])
            let action = UIAction { action in
                guard let sender = action.sender as? UIButton else {return}
                textField.isSecureTextEntry.toggle()
                textField.isSecureTextEntry ? sender.setImage(UIImage(systemName: "eye.fill"), for: .normal) :
                                            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            }
            button.addAction(action, for: .touchUpInside)
        }
        
        return textField
    }
    
    static func createStack(axis: NSLayoutConstraint.Axis = .vertical, alignment: UIStackView.Alignment = .fill, spacing: CGFloat,  views: UIView...) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        views.forEach {
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = true
        return stack
    }
    
    static func createCheckmark(btn: UIButton) -> UIButton {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.tintColor = AppColorSet.SignUp.checkmark
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 22.93),
            button.widthAnchor.constraint(equalToConstant: 22.93)
        ])
        let imageConfig = UIImage.SymbolConfiguration(scale: .large)
        let square = UIImage(systemName: "square", withConfiguration: imageConfig)
        let checkmarkSquare = UIImage(systemName: "checkmark.square", withConfiguration: imageConfig)
        button.setImage(square, for: .normal)
        let action = UIAction { action in
            guard let sender = action.sender as? UIButton else { return }
            if sender.currentImage == square {
                btn.isEnabled = true
                btn.layer.opacity = 1
                button.tintColor = AppColorSet.SignUp.selectedCheckmark
                button.setImage(checkmarkSquare, for: .normal)
            } else {
                btn.isEnabled = false
                btn.layer.opacity = 0.5
                button.tintColor = AppColorSet.SignUp.checkmark
                button.setImage(square, for: .normal)
                
            }
            
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }
    
    static func createAuthButton(title: String, color: UIColor, font: UIFont, bgColor: UIColor?, isEnabled: Bool = true, handler: @escaping UIActionHandler = {_ in}) -> UIButton {
        let button = UIButton(primaryAction: UIAction(handler: handler))
        let attributedTitle = NSAttributedString(string: title, attributes: [.font: font, .foregroundColor: color])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = bgColor
        button.isEnabled = isEnabled
        if button.isEnabled {
            button.layer.opacity = 1
        } else {
            button.layer.opacity = 0.5
        }
        button.layer.cornerRadius = 13.76
        button.heightAnchor.constraint(equalToConstant: 71.09).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createAuthTextButton(title: String, color: UIColor, font: UIFont, handler: @escaping UIActionHandler = {_ in}) -> UIButton {
        let button = UIButton(primaryAction: UIAction(handler: handler))
        let attributedTitle = NSAttributedString(string: title, attributes: [.font: font, .foregroundColor: color])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createCellTextLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = AppColorSet.NoteCell.text
        label.text = "Описание"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    static func createCellTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = AppColorSet.NoteCell.title
        label.text = "Заголовок"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createStarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = AppColorSet.NoteCell.star
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }
    
    static func createDateLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func dateToString(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func createSingOutButton(handler: @escaping UIActionHandler = {_ in}) -> UIButton {
        let button = UIButton(primaryAction: UIAction(handler: handler))
        button.layer.cornerRadius = 27.5
        button.layer.borderWidth = 1
        button.layer.borderColor = AppColorSet.Profile.singOutButtonBorder.cgColor
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.widthAnchor.constraint(equalToConstant: 286).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        let imageView = UIImageView(image: .signout)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.isUserInteractionEnabled = true
        
        let signOutLabel = UILabel()
        signOutLabel.text = "Выйти"
        signOutLabel.textColor = AppColorSet.Profile.singOutButtonTitle
        signOutLabel.isUserInteractionEnabled = true
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 15
        hStack.isUserInteractionEnabled = true
        hStack.addArrangedSubviews(imageView, signOutLabel)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            hStack.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        return button
    }
    
    static func createButton(text: String, textColor: UIColor = AppColorSet.Settings.text,
                             borderColor: CGColor = AppColorSet.Settings.button.cgColor,
                             handler: @escaping UIActionHandler = {_ in}) -> UIButton {
        let button = UIButton(primaryAction: UIAction(handler: handler))
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.layer.borderColor = borderColor
        button.heightAnchor.constraint(equalToConstant: 62).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
