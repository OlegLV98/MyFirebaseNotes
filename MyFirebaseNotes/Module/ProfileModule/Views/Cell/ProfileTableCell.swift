//
//  ProfileTableCell.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 20.06.2024.
//

import UIKit

class ProfileTableCell: UITableViewCell {

    lazy var infoLabel = AppUI.createLabel(text: "",
                                            color: AppColorSet.Profile.tableInfo,
                                            font: .systemFont(ofSize: 16, weight: .medium),
                                           textAlignment: .left)
    
    lazy var dataField: UITextField = {
        let textField = UITextField()
        textField.textColor = AppColorSet.Profile.tableData
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.textAlignment = .right
        return textField
    }()
    

    private lazy var hStack = AppUI.createStack(axis: .horizontal, spacing: 10, views: infoLabel, dataField)
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupCell(info: String, userData: String, isEditMode: Bool) {
        backgroundColor = .clear
        selectionStyle = .none
        infoLabel.text = info

        dataField.text = userData
        dataField.isEnabled = isEditMode
        if isEditMode {
            infoLabel.textColor = AppColorSet.Profile.tableInfoEdit
        } else {
            infoLabel.textColor = AppColorSet.Profile.tableInfo
        }
        addSubview(hStack)
        addSubview(separatorView)
        setConstraints()
    }
}

extension ProfileTableCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            separatorView.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 15),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
            
        ])
    }
}
