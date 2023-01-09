//
//  SurveyTableViewCell.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 09.01.2023.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {
    
    private let bgView = UIView()
    private let clearBgView = UIView()
    private let titleLabel = UILabel()
    
    
    func configureCell(text: String) {
        
        selectionStyle = .none
        
        backgroundView = clearBgView
        
        clearBgView.backgroundColor = .clear
        
        clearBgView.addSubview(bgView)
        clearBgView.addSubview(titleLabel)
        
        bgView.backgroundColor = .systemGray4
        bgView.layer.cornerRadius = 5
        bgView.clipsToBounds = true
        
        titleLabel.text = text
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -15),
            
            titleLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor)
        ])
    }
}
