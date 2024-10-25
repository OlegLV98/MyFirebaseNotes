//
//  UIImageView + ext.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 01.07.2024.
//

import UIKit

extension UIImageView {
    func load(url: URL?) {
        if let url {
            DispatchQueue.global(qos: .default).async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
        image = UIImage(named: "")
    }
    
    func getRatio() -> CGFloat {
        guard let image else {
            return 1
        }
        return image.size.height / image.size.width
    }
}
