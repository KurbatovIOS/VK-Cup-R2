//
//  DragVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 15.01.2023.
//

import UIKit

class DragingVC: UIViewController {
    
    private let questionLabel = UILabel()
    private let answersCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private let mainModel = MainModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
        
        configureQuestion()
        configureAnswers()
    }
    
    private func configureQuestion() {
        
        view.addSubview(questionLabel)
        
        questionLabel.text = "А вот и текст"
        questionLabel.font = .preferredFont(forTextStyle: .title2)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
        ])
    }
    
    private func configureAnswers() {
        
        view.addSubview(answersCollectionView)
        
        answersCollectionView.backgroundColor = .clear
        
        answersCollectionView.register(DragCollectionViewCell.self, forCellWithReuseIdentifier: Helpers.dragVCIdentifier)
        answersCollectionView.allowsSelection = false
        answersCollectionView.isScrollEnabled = false
        
        answersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            answersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            //answersCollectionView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 200),
            answersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            answersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}

extension DragingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: Helpers.dragVCIdentifier, for: indexPath) as! DragCollectionViewCell
        cell.backgroundColor = .purple
        cell.tag = indexPath.row
        cell.configureCell(text: "\(indexPath.row)")
        return cell
    }
}
