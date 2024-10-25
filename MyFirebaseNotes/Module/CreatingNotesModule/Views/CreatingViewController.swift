//
//  CreatingViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 29.06.2024.
//

import UIKit

protocol CreatingViewControllerProtocol: AnyObject {
    func popVC()
    func showAlert()
}

class CreatingViewController: UIViewController, CreatingViewControllerProtocol {
    var presenter: CreatingPresenterProtocol!
    
    private lazy var textField: UITextField = {
        $0.textColor = AppColorSet.CreatingNotes.TextField.text
        $0.attributedPlaceholder = NSAttributedString(string: "Заголовок", attributes: [.foregroundColor: UIColor.lightGray])
        $0.backgroundColor = AppColorSet.CreatingNotes.TextField.fieldBg
        $0.layer.cornerRadius = 10
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.font = .systemFont(ofSize: 16, weight: .light)
        $0.textColor = #colorLiteral(red: 0.8570356965, green: 0.8570356369, blue: 0.8570356369, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    private lazy var textView: UITextView = {
        $0.backgroundColor = AppColorSet.CreatingNotes.TextView.fieldBg
        $0.delegate = self
        $0.layer.cornerRadius = 10
        $0.font = .systemFont(ofSize: 16, weight: .light)
        $0.textColor = UIColor.lightGray
        $0.text = "Содержание"
        $0.contentInset = .init(top: 0, left: 13, bottom: 0, right: 13)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextView())
    
    lazy var loadImage = UIAction {[weak self]_ in
        guard let self else {return}
        present(imagePicker, animated: true)
    }
    
    private lazy var imagePicker: UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        return $0
    }(UIImagePickerController())
    
    lazy var loadImageButton: UIButton = {
        $0.backgroundColor = .none
        $0.setTitleColor(AppColorSet.CreatingNotes.loadImageButton, for: .normal)
        $0.layer.cornerRadius = 16
        $0.setTitle("Загрузить фото", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: loadImage))
    
    lazy var saveAction = UIAction {[weak self]_ in
        guard let self else {return}
        presenter.addNote(title: textField.text, text: textView.text, image: imageView.image)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "У заметки должны быть название и содердание!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) {_ in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var saveButton: UIButton = {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 16
        $0.backgroundColor = AppColorSet.CreatingNotes.SaveButton.buttonBg
        $0.setTitleColor(AppColorSet.CreatingNotes.SaveButton.text, for: .normal)
        $0.setTitle("Сохранить", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: saveAction))
    
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColorSet.Home.bgMainView
        view.addSubview(textField)
        view.addSubview(textView)
        view.addSubview(loadImageButton)
        view.addSubview(imageView)
        view.addSubview(saveButton)
        
        setConstraints()
    }
}

extension CreatingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.imageView.image = image
        }
        picker.dismiss(animated: true)
    }
}

extension CreatingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 59),
            
            textView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textView.heightAnchor.constraint(equalToConstant: 161),
            
            loadImageButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 12),
            loadImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: loadImageButton.bottomAnchor, constant: 17),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageView.heightAnchor.constraint(equalToConstant: 190),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 62),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
        ])
    }
}

extension CreatingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                textView.text = nil
            textView.textColor = AppColorSet.CreatingNotes.TextView.text
            }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
                textView.text = "Содержание"
                textView.textColor = UIColor.lightGray
            }
    }
}
