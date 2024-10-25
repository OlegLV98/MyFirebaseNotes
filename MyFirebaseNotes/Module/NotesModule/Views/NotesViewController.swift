//
//  NotesViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 29.06.2024.
//


import UIKit

protocol NotesViewControllerProtocol: AnyObject {
    func reloadData()
}

class NotesViewController: UIViewController, NotesViewControllerProtocol {

    var presenter: NotesPresenterProtocol!
    var folderId: String = ""
    
    
    
    lazy var collectionView: UICollectionView = {
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.reuseId)
        
        $0.register(CustomCollectionImageCell.self, forCellWithReuseIdentifier: CustomCollectionImageCell.reuseId)
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: view.frame.width - 60, height: 175)
        layout.minimumLineSpacing = 25
        $0.backgroundColor = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    lazy var addAction = UIAction {[weak self]_ in
        guard let self else {return}
        let creatingVC = ModuleBuilder.createCreatingModule(folderId: folderId)
        navigationController?.pushViewController(creatingVC, animated: true)
        navigationItem.backButtonTitle = "Назад"
    }
    
    lazy var addButton: UIButton = {
        $0.backgroundColor = AppColorSet.Notes.AddButton.buttonBg
        $0.layer.cornerRadius = 25
        var attrTitle = NSAttributedString(string: "+", attributes: [.foregroundColor: AppColorSet.Notes.AddButton.plus, .font: UIFont.systemFont(ofSize: 32)])
        $0.setAttributedTitle(attrTitle, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: addAction))
    
    func reloadData() {
        collectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.getNotes()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColorSet.Notes.bgMainView
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.clipboard.fill"), style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = AppColorSet.CreatingNotes.backButton
        
        view.addSubview(collectionView)
        view.addSubview(addButton)
        setConstraints()
    }
    
    @objc func deleteNote(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            let point = gesture.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: point) {
                presenter.deleteNote(noteNumber: indexPath.row)
                presenter.collectionData.remove(at: indexPath.row)
                collectionView.deleteItems(at: [indexPath])
            }
        }
    }
    
    @objc func addToFavorite(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            presenter.collectionData[indexPath.row].isFavorite = true
            reloadData()
            presenter.addToFavorite(noteNumber: indexPath.row)
        }
    }
}

extension NotesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionImageCell.reuseId, for: indexPath) as! CustomCollectionImageCell
        let textCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.reuseId, for: indexPath) as! CustomCollectionCell
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 1
        longPressGesture.addTarget(self, action: #selector(deleteNote))
        let doubleTapGesture = UITapGestureRecognizer()
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.addTarget(self, action: #selector(addToFavorite))
        guard let imageURL = presenter.collectionData[indexPath.row].imageURL, let url = URL(string: imageURL) else {
            textCell.addGestureRecognizer(longPressGesture)
            textCell.addGestureRecognizer(doubleTapGesture)
            textCell.setupCell(item: presenter.collectionData[indexPath.row])
            return textCell
        }
        imageCell.addGestureRecognizer(longPressGesture)
        imageCell.addGestureRecognizer(doubleTapGesture)
        imageCell.setupCell(item: presenter.collectionData[indexPath.row], url: url)
        return imageCell
        
    }
}

extension NotesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.heightAnchor.constraint(equalToConstant: 52),
            addButton.widthAnchor.constraint(equalToConstant: 52),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
        ])
    }
}
