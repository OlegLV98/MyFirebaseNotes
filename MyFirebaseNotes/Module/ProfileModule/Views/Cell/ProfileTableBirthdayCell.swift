//
//  ProfileTableBirthdayCell.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.07.2024.
//

import UIKit

class ProfileTableBirthdayCell: UITableViewCell {

    lazy var infoLabel = AppUI.createLabel(text: "",
                                            color: AppColorSet.Profile.tableInfoEdit,
                                            font: .systemFont(ofSize: 16, weight: .medium),
                                           textAlignment: .left)
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.cornerRadius = 5
        datePicker.clipsToBounds = true
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = AppColorSet.Profile.datePicker
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    func setupCell(info: String) {
        backgroundColor = .clear
        selectionStyle = .none
        infoLabel.text = info
        contentView.addSubview(infoLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(separatorView)
        setConstraints()
    }

}

extension ProfileTableBirthdayCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),

            separatorView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 15),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
    }
}
