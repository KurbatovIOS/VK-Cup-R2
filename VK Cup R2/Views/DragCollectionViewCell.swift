//
//  DragCollectionViewCell.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 15.01.2023.
//

import UIKit

class DragCollectionViewCell: UICollectionViewCell {
    
    private let answerLabel = UILabel()
    
    private var initialCenter = CGPoint()
    
    func configureCell(text: String) {
        
        backgroundColor = .systemBlue.withAlphaComponent(0.3)
        
        addSubview(answerLabel)

        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
                
        answerLabel.text = text
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 0

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            answerLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
