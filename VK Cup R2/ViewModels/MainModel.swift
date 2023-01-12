//
//  MainModel.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 06.01.2023.
//

import Foundation
import UIKit

class MainModel {
    

    func createCollectionView(withInset: Bool = false) -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        if withInset {
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        }
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }
    
    func clickAnimation(view: UIView) {

        let viewsOriginalTransform = view.transform

        UIView.animate(withDuration: 0.6, delay: 0) {
            view.transform = CGAffineTransformScale(viewsOriginalTransform, 1.1, 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.6, delay: 0) {
                view.transform = CGAffineTransformScale(viewsOriginalTransform, 1, 1)
            }
        }

    }
    
}
