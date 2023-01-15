//
//  ViewController.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 05.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var elementsCollectionView: UICollectionView!
    private let elements = ["Опрос", "Сопоставление", "Перетаскивание вариантов", "Заполнение пропусков", "Оценка"]
    
    private let model = MainModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        elementsCollectionView = model.createCollectionView()
        
        elementsCollectionView.delegate = self
        elementsCollectionView.dataSource = self
        
        view.backgroundColor = .systemBackground
        
        navigationItem.backButtonTitle = ""
        
        configureElementsCollectionView()
    }
        
    private func configureElementsCollectionView() {
        
        view.addSubview(elementsCollectionView)
        
        elementsCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: Helpers.homeVCIdentifier)
        
        elementsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        elementsCollectionView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            elementsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            elementsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            elementsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            elementsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = elementsCollectionView.dequeueReusableCell(withReuseIdentifier: Helpers.homeVCIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.configureCell(text: elements[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = elementsCollectionView.frame.width
        let heigh = view.frame.height * 0.1
        
        return CGSize(width: width, height: heigh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationVC: Any?
        
        switch indexPath.row {
        case 0:
            destinationVC = SurveyVC()
        case 1:
            destinationVC = ComparisonVC()
        case 2:
            destinationVC = DragingVC()
        case 3:
            destinationVC = FillTextVC()
        case 4:
            destinationVC = RatingVC()
        default:
            destinationVC = SurveyVC()
        }
        
        navigationController?.pushViewController(destinationVC as! UIViewController, animated: true)
    }
}
