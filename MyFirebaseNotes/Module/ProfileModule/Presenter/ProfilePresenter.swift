//
//  ProfilePresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewControllerProtocol)
    func signOut()
    var userDataLabels: [String] { get }
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    lazy var profileModel = ProfileModel.shared
    var userData = UserData()
    var userDataArray: [String] {
        return [userData.name ?? "", userData.email ?? "", userData.phone ?? "", userData.dateOfBirth ?? "", userData.address ?? ""]
    }
    weak var view: ProfileViewControllerProtocol?
    let userDataLabels: [String] = ["Имя: ", "Почта: ", "Телефон: ", "День рождения: ", "Адрес: "]
    required init(view: ProfileViewControllerProtocol) {
        self.view = view
        getUserData()
    }
    
    func updateUserData(data: [String: Any]) {
        profileModel.updateUserData(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserData() {
        profileModel.getUserData {  result in
            switch result {
            case .success(let userData):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.userData = userData
                    view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveProfileImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        profileModel.saveProfileImage(image: data) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func signOut() {
        profileModel.signOut()
        NotificationCenter.default.post(name: .setVC, object: nil, userInfo: ["vcType" : VCType.signIn])
    }
}
