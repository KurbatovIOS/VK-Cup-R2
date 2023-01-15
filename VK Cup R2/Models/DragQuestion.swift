//
//  DragQuestion.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 15.01.2023.
//

import Foundation

struct DragQuestion: Decodable {
    
    let question: String
    let answers: [String]
    let correctAnswers: [Int]
    let answerIndexes: [Int]
}
