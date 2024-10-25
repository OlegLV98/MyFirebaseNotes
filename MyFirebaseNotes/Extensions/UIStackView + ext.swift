//
//  UIStackView + ext.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
