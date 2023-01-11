//
//  ComparisonModel.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 11.01.2023.
//

import Foundation

import UIKit

protocol ComparisonModelDelegate {
    
    func getData(_ data: [Comparison])
}

class ComparisonModel {
    
    var delegate: ComparisonModelDelegate?
    
    func loadData() {
        
        guard let path = Bundle.main.path(forResource: "ComparisonData", ofType: "json") else { return }
        
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
       
        do {
            let data = try Data(contentsOf: url)
            let decoded = try decoder.decode([Comparison].self, from: data)
            delegate?.getData(decoded)
        }
        catch {
            print("Error")
        }
    }
}
