//
//  FillTextVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 13.01.2023.
//

import UIKit

class FillTextVC: UIViewController {
    
    private let textLabel = UILabel()
    private let answerTextField = UITextField()
    
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        configureText()
        configureButton()
    }
    
    private func configureText() {
        
        view.addSubview(textLabel)
        
        textLabel.text = "Заполни _____ пропуски как _____ скорее"
        textLabel.font = .preferredFont(forTextStyle: .title2)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
    func configureButton() {
        
        view.addSubview(button)
        
        button.configuration = .filled()
        button.configuration?.title = "AAA"
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func buttonAction() {
        
        textLabel.text = textLabel.text?.replacingOccurrences(of: "_____", with: "AAA")
        
    }
}
