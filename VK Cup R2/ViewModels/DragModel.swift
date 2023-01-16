//
//  DragModel.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 15.01.2023.
//

import Foundation
import UIKit

protocol DragModelDelegate {
    
    func getData(_ data: [DragQuestion])
}

class DragModel {
        
    var delegate: DragModelDelegate?
    
    func loadData() {
        
        guard let path = Bundle.main.path(forResource: "DragData", ofType: "json") else { return }
        
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
       
        do {
            let data = try Data(contentsOf: url)
            let decoded = try decoder.decode([DragQuestion].self, from: data)
            delegate?.getData(decoded)
        }
        catch {
            print("Error")
        }
    }
}
