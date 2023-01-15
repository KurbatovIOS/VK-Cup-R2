//
//  СomparisonVС.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 11.01.2023.
//

import UIKit

class ComparisonVC: UIViewController {
    
    private let titleLabel = UILabel()
    
    private var leftColumnCollectionView: UICollectionView!
    private var rightColumnCollectionView: UICollectionView!
    
    private var elements = [Comparison]()
    
    private let mainModel = MainModel()
    private let comparisonModel = ComparisonModel()
    
    private var selectedPairIndexPaths: (left: IndexPath?, right: IndexPath?)
    private var currentComparisonIndex = 0
    
    private var correctPairCounter = 0 {
        didSet{
            if correctPairCounter == 4 {
                leftColumnCollectionView.reloadData()
                rightColumnCollectionView.reloadData()
                correctPairCounter = 0
                currentComparisonIndex += 1
                if currentComparisonIndex == elements.count {
                    currentComparisonIndex = 0
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        leftColumnCollectionView = mainModel.createCollectionView(withInset: true)
        leftColumnCollectionView.delegate = self
        leftColumnCollectionView.dataSource = self
        
        rightColumnCollectionView = mainModel.createCollectionView(withInset: true)
        rightColumnCollectionView.delegate = self
        rightColumnCollectionView.dataSource = self
        
        comparisonModel.delegate = self
        comparisonModel.loadData()
        
        configureTitle()
        configureCollectionView(leftColumnCollectionView)
        configureCollectionView(rightColumnCollectionView)
    }
    
    
    private func configureTitle() {
        
        view.addSubview(titleLabel)
        
        titleLabel.text = "Сопоставьте элементы из двух столбцов"
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.numberOfLines = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
    
    private func configureCollectionView(_ collectionView: UICollectionView) {
        
        view.addSubview(collectionView)
        
        let identifier = collectionView == leftColumnCollectionView ? Helpers.letfColumnIdentifier : Helpers.rightColumnIdentifier
        
        collectionView.register(ComparisonCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
        
        if collectionView == leftColumnCollectionView {
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        }
        else {
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        }
    }
}

extension ComparisonVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return elements[0].leftCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = collectionView == leftColumnCollectionView ? Helpers.letfColumnIdentifier : Helpers.rightColumnIdentifier
        let text = collectionView == leftColumnCollectionView ? elements[currentComparisonIndex].leftCollection[indexPath.row] : elements[currentComparisonIndex].rightCollection[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ComparisonCollectionViewCell
        cell.configureCell(text: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 20
        
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            mainModel.clickAnimation(view: cell)
            cell.backgroundColor = .systemGray5
        }
        
        collectionView.allowsSelection = false
        
        if collectionView == leftColumnCollectionView {
            selectedPairIndexPaths.left = indexPath
        } else {
            selectedPairIndexPaths.right = indexPath
        }
        
        if selectedPairIndexPaths.left != nil && selectedPairIndexPaths.right != nil {
            
            let leftCell = leftColumnCollectionView.cellForItem(at: selectedPairIndexPaths.left!)
            let rightCell = rightColumnCollectionView.cellForItem(at: selectedPairIndexPaths.right!)
            
            if elements[currentComparisonIndex].matching.contains(where: { pair in
                pair.leftIndex == selectedPairIndexPaths.left?.row && pair.rightIndex == selectedPairIndexPaths.right?.row
            }) {
                // it's a match

                UIView.animate(withDuration: 1) {
                    leftCell?.backgroundColor = .green
                    rightCell?.backgroundColor = .green
                } completion: { _ in
                    UIView.animate(withDuration: 0.2) {
                        leftCell?.alpha = 0
                        rightCell?.alpha = 0
                    } completion: { _ in
                        self.correctPairCounter += 1
                    }
                }
            }
            else {
                // it's not a match
    
                UIView.animate(withDuration: 1.2) {
                    leftCell?.backgroundColor = .red
                    rightCell?.backgroundColor = .red
                } completion: { _ in
                    leftCell?.backgroundColor = .systemBackground
                    rightCell?.backgroundColor = .systemBackground
                }
            }
        
            // TODO: Create funtions to reduce duplicated code
           
            selectedPairIndexPaths.left = nil
            selectedPairIndexPaths.right = nil
            
            leftColumnCollectionView.allowsSelection = true
            rightColumnCollectionView.allowsSelection = true
        }
    }
}

extension ComparisonVC: ComparisonModelDelegate {
    
    func getData(_ data: [Comparison]) {
        elements = data
    }
}
