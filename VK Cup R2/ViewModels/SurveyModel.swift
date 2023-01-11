//
//  SurveyModel.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 07.01.2023.
//

import Foundation
import UIKit

protocol SurveyModelDelegate {
    
    func getQuestions(_ questions: [Question])
}

class SurveyModel {
    
    var survey = [Question]()
    var delegate: SurveyModelDelegate?
    
    func loadQuestions() {
        
        guard let path = Bundle.main.path(forResource: "SurveyData", ofType: "json") else { return }
        
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
       
        do {
            let data = try Data(contentsOf: url)
            survey = try decoder.decode([Question].self, from: data)
            delegate?.getQuestions(self.survey)
        }
        catch {
            print("Error")
        }
    }
    
    func checkAnswer() -> (correctIndex: Int, wrongIndex: Int?) {
        
        
        
        return (1, nil)
    }
}
