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
        
        layer.cornerRadius = 5
                
        elementLabel.text = text

        elementLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            elementLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            elementLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            elementLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
