//
//  HomeCollectionViewCell.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 14.01.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    private let answerLabel = UILabel()
    
    func configureCell(text: String) {
        
        backgroundColor = .systemBlue
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(answerLabel)
        
        answerLabel.text = text
        answerLabel.textColor = .white
        answerLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        answerLabel.numberOfLines = 0
        answerLabel.textAlignment = .center
                
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
