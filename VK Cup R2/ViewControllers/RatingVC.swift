//
//  RatingVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 10.01.2023.
//

import UIKit

class RatingVC: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let star1ImageView = UIImageView()
    private let star2ImageView = UIImageView()
    private let star3ImageView = UIImageView()
    private let star4ImageView = UIImageView()
    private let star5ImageView = UIImageView()
    
    private let starsStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
    }
    
}
