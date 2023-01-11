//
//  Comparison.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 11.01.2023.
//

import Foundation

struct Comparison: Decodable {
    
    let leftCollection: [String]
    let rightCollection: [String]
    let matching: [Pairs]
}

struct Pairs: Decodable {
    let leftIndex: Int
    let rightIndex: Int
}

