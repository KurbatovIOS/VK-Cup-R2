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
        
        backgroundColor = .systemBackground
        
        addSubview(answerLabel)

        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
                
        answerLabel.text = text
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 0

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePenGesture)))
        self.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            answerLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc private func handelTapGesture(gesture: UITapGestureRecognizer) {
        
        self.transform = CGAffineTransform(translationX: 180.3333282470703, y: 123.0)
        
    }
    
    @objc private func handlePenGesture(gesture: UIPanGestureRecognizer) {
        
        let cell = gesture.view!
        let translation = gesture.translation(in: cell.superview)
        
        if gesture.state == .began {
           
            self.initialCenter = cell.center
        }
        else if gesture.state != .cancelled {
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            cell.center = newCenter
        }
        else {
            cell.center = initialCenter
        }
    }
}
