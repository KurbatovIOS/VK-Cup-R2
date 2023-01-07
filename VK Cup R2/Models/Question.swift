//
//  Survey.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 06.01.2023.
//

import Foundation

struct Question: Decodable {
    
    let question: String
    let answers: [String]
    let correctIndex: Int
}
