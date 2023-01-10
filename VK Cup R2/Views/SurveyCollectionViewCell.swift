//
//  SurveyCollectionViewCell.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 10.01.2023.
//

import UIKit

class SurveyCollectionViewCell: UICollectionViewCell {
    
    private let answerLabel = UILabel()
    let answerPercent = UILabel()
    
    func configureCell(answer: String, percent: Int) {
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 5
        
        addSubview(answerLabel)
        addSubview(answerPercent)
        
        answerLabel.text = answer
        answerLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        answerLabel.numberOfLines = 0
        
        answerPercent.text = "\(percent)%"
        answerPercent.alpha = 0
        answerPercent.textAlignment = .right
        
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerPercent.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            answerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            answerPercent.leadingAnchor.constraint(equalTo: answerLabel.trailingAnchor, constant: 5),
            answerPercent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            answerPercent.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
