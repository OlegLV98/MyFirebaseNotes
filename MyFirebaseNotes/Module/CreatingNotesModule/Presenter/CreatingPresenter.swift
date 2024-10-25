//
//  CreatingPresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 29.06.2024.
//

import UIKit
protocol CreatingPresenterProtocol: AnyObject {
    init(view: CreatingViewControllerProtocol, model: CreatingModel, folderId: String)
    func addNote(title: String?, text: String?, image: UIImage?)
}
class CreatingPresenter: CreatingPresenterProtocol {
    weak var view: CreatingViewControllerProtocol?
    lazy var creatingModel = CreatingModel.shared
    var folderId: String = ""
    
    func addNote(title: String?, text: String?, image: UIImage?) {
        let imageData = image?.jpegData(compressionQuality: 0.1)
        guard let title = title, let text = text, !title.isEmpty, !text.isEmpty else {
            view?.showAlert()
            return
        }
        creatingModel.addNote(title: title, text: text, imageData: imageData, folderId: folderId) { [weak self]error in
            guard let self, let view else {return}
            if let error = error {
                print(error.localizedDescription)
            } else {
                view.popVC()
            }
        }
    }
    
    required init(view: CreatingViewControllerProtocol, model: CreatingModel, folderId: String) {
        self.view = view
        self.folderId = folderId
        self.creatingModel = model
    }
}
