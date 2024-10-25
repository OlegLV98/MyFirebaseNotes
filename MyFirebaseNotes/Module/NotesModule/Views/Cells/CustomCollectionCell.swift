//
//  CustomCollectionCell.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 29.06.2024.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    static let reuseId = "CustomCollectionCell"
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var titleLabel = AppUI.createCellTitleLabel()
    
    private lazy var textLabel = AppUI.createCellTextLabel()
    
    private lazy var creationDateLabel = AppUI.createDateLabel()
    
    private lazy var starImageView = AppUI.createStarImageView()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, starImageView])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func setupCell(item: Note) {
        backgroundColor = AppColorSet.NoteCell.bgCell
        layer.cornerRadius = 20
        addSubview(view)
        [hStack, textLabel, creationDateLabel].forEach {view.addSubview($0)}
        
        creationDateLabel.text = AppUI.dateToString(date: item.creationDate)
        titleLabel.text = item.title
        textLabel.text = item.text
        starImageView.isHidden = !item.isFavorite
        setConstraints()
        
    }
}

extension CustomCollectionCell {
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
            
            creationDateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 5),
            creationDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            creationDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            creationDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
