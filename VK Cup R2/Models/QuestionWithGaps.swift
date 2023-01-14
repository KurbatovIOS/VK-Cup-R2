//
//  QuestionWithGaps.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 14.01.2023.
//

import Foundation

struct QuestionWithGaps: Decodable {
    
    let question: String
    let correctAnswers: [String]
    let answerIndexes: [Int]
}
