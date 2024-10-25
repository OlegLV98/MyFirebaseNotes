//
//  ProfileViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    func reloadData()
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    var presenter: ProfilePresenter!


    func updateUserData() {
        var data: [String] = []
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            if row == 3 && !isEditMode {
                let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ProfileTableBirthdayCell
                let date = AppUI.dateToString(date: cell.datePicker.date)
                data.append(date)
            } else {
                let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ProfileTableCell
                data.append(cell.dataField.text ?? "")
            }
        }
        let updatedData = [
                "name" : data[0],
                "email" : data[1],
                "phone" : data[2],
                "date_of_birth" : data[3],
                "address" : data[4],
            ]
        presenter.updateUserData(data: updatedData)
    }
   
    var isEditMode: Bool = false {
        didSet {
            updateUserData()
            presenter.getUserData()
        }
    }
    lazy var avaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 80
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = AppColorSet.Profile.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(editPhoto))
        imageView.addGestureRecognizer(tapGesture)
        
        return imageView
    }()
 
    private lazy var imagePicker: UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        return $0
    }(UIImagePickerController())
    
    @objc func editPhoto(sender: UIImageView) {
        present(imagePicker, animated: true)
    }
    
    lazy var nameLabel = AppUI.createLabel(text: "Александр Новиков",
                                            color: AppColorSet.Profile.nameLabel,
                                            font: .systemFont(ofSize: 30, weight: .heavy),
                                            textAlignment: .center)
    
    lazy var emailLabel = AppUI.createLabel(text: "anovikov@gmail.com",
                                            color: AppColorSet.Profile.emailLabel,
                                            font: .systemFont(ofSize: 16, weight: .light),
                                            textAlignment: .center)
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.register(ProfileTableCell.self, forCellReuseIdentifier: "ProfileTableCell")
        table.register(ProfileTableBirthdayCell.self, forCellReuseIdentifier: "ProfileTableBirthdayCell")
        table.bouncesVertically = false
        table.separatorStyle = .none
        table.dataSource = self
       
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var singOutButton = AppUI.createSingOutButton() { [weak self]_ in
        guard let self else { return }
        presenter.signOut()
    }
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(primaryAction: editAction)
        button.tintColor = AppColorSet.Profile.editButton
        button.image = UIImage(systemName: "pencil")
        return button
    }()
    
    lazy var editAction = UIAction {[weak self]_ in
        guard let self else {return}
        isEditMode = !isEditMode
        isEditMode ? (editButton.image = UIImage(systemName: "checkmark.circle")): (editButton.image = UIImage(systemName: "pencil"))
    }
    
    private lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(primaryAction: settingsAction)
        button.image = UIImage(systemName: "gearshape")
        button.tintColor = AppColorSet.Profile.settingsButton
        button.style = .plain
        return button
    }()
    
    lazy var settingsAction = UIAction {[weak self]_ in
        guard let self else {return}
        let settingsVC = ModuleBuilder.createSettingsModule()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter(view: self)
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = AppColorSet.Settings.backButton
        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem = editButton
        view.backgroundColor = AppColorSet.Profile.bgMainView
        
        [avaImageView, nameLabel, emailLabel, tableView, singOutButton].forEach {view.addSubview($0)}
        setConstraints()
    }

    func reloadData() {
        nameLabel.text = presenter.userData.name
        emailLabel.text = presenter.userData.email
        tableView.reloadData()
        guard let imageURL = presenter.userData.photoUrl, let url = URL(string: imageURL) else {
            return
        }
        avaImageView.load(url: url)
        
    }
}

extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            avaImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            avaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avaImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: singOutButton.topAnchor, constant: -15),
            
            singOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            singOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110)
        ])
    }
}

//MARK: UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.avaImageView.image = image
            self.presenter.saveProfileImage(image: image)
        }
        picker.dismiss(animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.userDataLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableCell", for: indexPath) as! ProfileTableCell
        let birthdayCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableBirthdayCell", for: indexPath) as! ProfileTableBirthdayCell

        if indexPath.row == 1 {
            cell.setupCell(info: presenter.userDataLabels[indexPath.row], userData: presenter.userDataArray[indexPath.row], isEditMode: false)
        } else if indexPath.row == 3 && isEditMode {
            birthdayCell.setupCell(info: presenter.userDataLabels[indexPath.row])
            return birthdayCell
        } else {
            cell.setupCell(info: presenter.userDataLabels[indexPath.row], userData: presenter.userDataArray[indexPath.row], isEditMode: isEditMode)
        }
        return cell
    }
}

