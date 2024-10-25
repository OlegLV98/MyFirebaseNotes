//
//  NotesPresenter.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 29.06.2024.
//

import Foundation

protocol NotesPresenterProtocol: AnyObject {
    init(view: NotesViewControllerProtocol, model: NotesModel, folderId: String)
    var collectionData: [Note] {get set}
    var folderId: String {get set}
    func getNotes()
    func deleteNote(noteNumber: Int)
    func addToFavorite(noteNumber: Int)
}
class NotesPresenter: NotesPresenterProtocol {
    weak var view: NotesViewControllerProtocol?
    var notesModel: NotesModel!
    
    var folderId: String = ""
    
    lazy var collectionData = [Note]()
    
    func deleteNote(noteNumber: Int) {
        notesModel.deleteNote(note: collectionData[noteNumber]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addToFavorite(noteNumber: Int) {
        let note = collectionData[noteNumber]
        notesModel.addToFavorite(note: note) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getNotes() {
        notesModel.getNotes(folderId: folderId) {[weak self] result in
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
    
    required init(view: NotesViewControllerProtocol, model: NotesModel, folderId: String) {
        self.view = view
        self.notesModel = model
        self.folderId = folderId
    }
}
