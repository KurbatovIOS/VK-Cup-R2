//
//  SurveyCollectionViewCell.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 10.01.2023.
//

import UIKit

class SurveyCollectionViewCell: UICollectionViewCell {
    
    private let answerLabel = UILabel()
    
    func configureCell(answer: String) {
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 5
        
        addSubview(answerLabel)
        
        answerLabel.text = answer
        answerLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        answerLabel.numberOfLines = 0
        
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
