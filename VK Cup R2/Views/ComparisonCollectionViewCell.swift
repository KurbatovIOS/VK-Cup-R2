//
//  ComperisonCollectionViewCell.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 11.01.2023.
//

import UIKit

class ComparisonCollectionViewCell: UICollectionViewCell {
    
    private let elementLabel = UILabel()
    
    func configureCell(text: String) {
        
        addSubview(elementLabel)
        
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
                
        elementLabel.text = text
        elementLabel.textAlignment = .center
        elementLabel.numberOfLines = 0

        elementLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            elementLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            elementLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            elementLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            elementLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
