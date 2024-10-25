//
//  CustomTableViewCell.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 29.06.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 17, weight: .light)
        $0.textColor = AppColorSet.Home.FolderCell.title
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var folderImageView: UIImageView = {
        $0.image = UIImage(systemName: "folder")
        $0.tintColor = AppColorSet.Home.FolderCell.image
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(folderImageView)
        NSLayoutConstraint.activate([
            folderImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            folderImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: folderImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
    
    func setupCell(item: Folder) {
        backgroundColor = AppColorSet.Home.FolderCell.bgCell
        nameLabel.text = item.name
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
