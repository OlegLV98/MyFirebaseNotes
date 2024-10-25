//
//  ModuleBuilder.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 01.07.2024.
//

import UIKit

protocol Builder {
    static func createNotesModule(folderName: String, folderId: String) -> UIViewController
    static func createCreatingModule(folderId: String) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createNotesModule(folderName: String, folderId: String) -> UIViewController {
        let model = NotesModel.shared
        let view = NotesViewController()
        view.title = folderName
        view.folderId = folderId
        let presenter = NotesPresenter(view: view, model: model, folderId: folderId)
        view.presenter = presenter
        return view
    }
    
    static func createCreatingModule(folderId: String) -> UIViewController {
        let model = CreatingModel.shared
        let view = CreatingViewController()
        let presenter = CreatingPresenter(view: view, model: model, folderId: folderId)
        view.presenter = presenter
        return view
    }
    
    static func createSettingsModule() -> UIViewController {
        let model = SettingsModel.shared
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
