//
//  FavoritePresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 13.06.2024.
//

import UIKit

protocol FavoritePresenterProtocol: AnyObject {
    init(view: FavoriteViewControllerProtocol)
    var collectionData: [Note] {get set}
    func deleteNote(noteNumber: Int)
    func getNotes()
}

class FavoritePresenter: FavoritePresenterProtocol {
    
    weak var view: FavoriteViewControllerProtocol?
    
    var favoriteModel = FavoriteModel.shared
    
    required init(view: FavoriteViewControllerProtocol) {
        self.view = view
    }
    
    lazy var collectionData = [Note]()
    
    func deleteNote(noteNumber: Int) {
        let note = collectionData[noteNumber]
        favoriteModel.deleteNote(note: note) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getNotes() {
        favoriteModel.getNotes() {[weak self] result in
            guard let self else {return}
            switch result {
            case .success(let notes):
                DispatchQueue.main.async {[weak self] in
                    guard let self, let view else {return}
                    collectionData = notes.sorted {$0.creationDate! > $1.creationDate!}
                    view.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

