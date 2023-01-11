//
//  СomparisonVС.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 11.01.2023.
//

import UIKit

class ComparisonVC: UIViewController {
    
    private let titleLabel = UILabel()
    private let hintButton = UIButton()
    
    private var leftColumnCollectionView: UICollectionView!
    private var rightColumnCollectionView: UICollectionView!
    
    private var elements = [Comparison]()
    
    private let mainModel = MainModel()
    private let comparisonModel = ComparisonModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        leftColumnCollectionView = mainModel.createCollectionView()
        rightColumnCollectionView = mainModel.createCollectionView()
        
        comparisonModel.delegate = self
        comparisonModel.loadData()
    }
}

extension ComparisonVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return elements[0].leftCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == leftColumnCollectionView {
            let cell = leftColumnCollectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! ComparisonCollectionViewCell
            return cell
        }
        else {
            let cell = rightColumnCollectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! ComparisonCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        collectionView.allowsSelection = false
        
        if collectionView == leftColumnCollectionView && rightColumnCollectionView.allowsSelection == false {
            
            // chack match
            // show result
            // if it was the last pare show next question
        }
        else {
        }
    }
}

extension ComparisonVC: ComparisonModelDelegate {
    
    func getData(_ data: [Comparison]) {
        elements = data
    }
}
