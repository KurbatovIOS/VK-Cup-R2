//
//  MainModel.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 06.01.2023.
//

import Foundation
import UIKit

class MainModel {
    

    func createCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }
    
//    func buttonAnimation(view: UIView) {
//
//        let viewsOriginalTransform = view.transform
//
//        UIView.animate(withDuration: 0.6, delay: 0) {
//            view.transform = CGAffineTransformScale(viewsOriginalTransform, 1.1, 1.1)
//        } completion: { _ in
//            UIView.animate(withDuration: 0.6, delay: 0) {
//                view.transform = CGAffineTransformScale(viewsOriginalTransform, 1, 1)
//            }
//        }
//
//    }
    
}
