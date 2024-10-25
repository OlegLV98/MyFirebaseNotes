//
//  FavoriteViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 13.06.2024.
//

import UIKit

protocol FavoriteViewControllerProtocol: AnyObject {
    func reloadData()
}

class FavoriteViewController: UIViewController, FavoriteViewControllerProtocol {
    var presenter: FavoritePresenterProtocol!
    
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
    
    func reloadData() {
        collectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.getNotes()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(view: self)
        view.backgroundColor = AppColorSet.Favorite.bgMainView
        view.addSubview(collectionView)
        title = "Избранное"
    
        setConstraints()
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionImageCell.reuseId, for: indexPath) as! CustomCollectionImageCell
        let textCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.reuseId, for: indexPath) as! CustomCollectionCell
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 1
        longPressGesture.addTarget(self, action: #selector(deleteNote))
        
        guard let imageURL = presenter.collectionData[indexPath.row].imageURL, let url = URL(string: imageURL) else {
            textCell.addGestureRecognizer(longPressGesture)
            textCell.setupCell(item: presenter.collectionData[indexPath.row])
            return textCell
        }
        imageCell.addGestureRecognizer(longPressGesture)
        imageCell.setupCell(item: presenter.collectionData[indexPath.row], url: url)
        return imageCell
    }
}

extension FavoriteViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
