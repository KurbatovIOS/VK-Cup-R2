//
//  FillGapModel.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 14.01.2023.
//

import Foundation

protocol FillGapModelDelegate {
    
    func getData(_ data: [QuestionWithGaps])
}

class FillGapModel {
        
    var delegate: FillGapModelDelegate?
    
    func loadData() {
        
        guard let path = Bundle.main.path(forResource: "FillGapData", ofType: "json") else { return }
        
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
       
        do {
            let data = try Data(contentsOf: url)
            let decoded = try decoder.decode([QuestionWithGaps].self, from: data)
            delegate?.getData(decoded)
        }
        catch {
            print("Error")
        }
    }
}
