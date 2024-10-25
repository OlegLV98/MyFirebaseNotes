//
//  HomePresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 13.06.2024.
//

import UIKit

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewControllerProtocol)
    func addFolder(name: String)
    var tableData: [Folder] {get set}
    func getFolders()
    func deleteFolder(indexPath: IndexPath)
}

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewControllerProtocol?
    lazy var homeModel = HomeModel.shared
    lazy var tableData = [Folder]()
    func addFolder(name: String) {
        if name.isEmpty {
            view?.showAlert()
            return
        }
        homeModel.addFolder(name: name) { result in
            switch result {
            case .success(let folder):
                DispatchQueue.main.async {[weak self] in
                    guard let self, let view else {return}
                    tableData.append(folder)
                    view.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteFolder(indexPath: IndexPath) {
        let folderId = tableData[indexPath.row].id
        
        homeModel.deleteFolder(folderId: folderId) {[weak self] error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self, let view else {return}
                    tableData.remove(at: indexPath.row)
                    view.deleteRow(indexPath: indexPath)
                    view.reloadData()
                }
            }
        }
    }
    
    func getFolders() {
        homeModel.getFolders { result in
            switch result {
            case .success(let folders):
                DispatchQueue.main.async {[weak self] in
                    guard let self, let view else {return}
                    tableData = folders
                    view.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    required init(view: HomeViewControllerProtocol) {
        self.view = view
    }
}
