//
//  RatingVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 10.01.2023.
//

import UIKit

class RatingVC: UIViewController {
    
    private let titleLabel = UILabel()
        
    private var starButtonCollection = [UIButton]()
    
    private let starsStack = UIStackView()
    
    private var rating = 0 {
        didSet {
            for starButton in starButtonCollection {
                let imageName = starButton.tag < rating ? "star.fill" : "star"
                starButton.setImage(UIImage(systemName: imageName), for: .normal)
                starButton.tintColor = starButton.tag < rating ? .systemOrange : .systemGray2
                starButton.addTarget(self, action: #selector(updateRating), for: .touchUpInside)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureStars()
        rating = 0
        configureTitle()
    }
    
    private func configureTitle() {
        
        view.addSubview(titleLabel)
        
        titleLabel.text = "Пожалуйста, оцените статью"
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: starsStack.topAnchor, constant: -40)
        ])
        
    }
    
    private func configureStars() {
        
        view.addSubview(starsStack)
        
        starsStack.axis = .horizontal
        starsStack.distribution = .equalSpacing
        starsStack.spacing = 5
        starsStack.alignment = .center
        
        for i in 0..<5 {
            let starButton = UIButton()
            starButton.tag = i
            starButton.addTarget(self, action: #selector(updateRating), for: .touchUpInside)
            starButtonCollection.append(starButton)
            starsStack.addArrangedSubview(starButton)
        }
                        
        starsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starsStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            starsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
    
    @objc private func updateRating(sender: UIButton) {
        rating = sender.tag + 1
        titleLabel.alpha = 0
        titleLabel.text = "Спасибо за ваш отзыв!"
        UIView.animate(withDuration: 1) {
            self.titleLabel.alpha = 1
        }
    }
}
