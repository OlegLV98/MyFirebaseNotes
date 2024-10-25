//
//  CustomCollectionImageCell.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 08.07.2024.
//

import UIKit

class CustomCollectionImageCell: UICollectionViewCell {
    static let reuseId = "CustomCollectionImageCell"
    var viewWidth: CGFloat = 0
    private lazy var view: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        viewWidth = UIScreen.main.bounds.width - 60
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        textLabel.text = nil
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var titleLabel = AppUI.createCellTitleLabel()
    
    private lazy var textLabel = AppUI.createCellTextLabel()
    
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var starImageView = AppUI.createStarImageView()
    
    private lazy var creationDateLabel = AppUI.createDateLabel()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, starImageView])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func setupCell(item: Note, url: URL) {
        backgroundColor = AppColorSet.NoteCell.bgCell
        layer.cornerRadius = 20
        addSubview(view)
        [hStack, textLabel, imageView, creationDateLabel].forEach {view.addSubview($0)}
        creationDateLabel.text = AppUI.dateToString(date: item.creationDate)
        titleLabel.text = item.title
        textLabel.text = item.text
        starImageView.isHidden = !item.isFavorite
        
        imageView.load(url: url)
        setConstraints()
    }
}

extension CustomCollectionImageCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.widthAnchor.constraint(equalToConstant: viewWidth),
            
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            textLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 12),
            
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 11),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            imageView.heightAnchor.constraint(equalToConstant: viewWidth),
            
            creationDateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            creationDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            creationDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            creationDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
