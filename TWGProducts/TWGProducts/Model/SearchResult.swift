//
//  SearchResult.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import Foundation

struct SearchResult: Codable {
    let result: [Item]?
    let hitCount: String
    let found: String
    
    enum CodingKeys: String, CodingKey {
        case result = "Results"
        case hitCount = "HitCount"
        case found = "Found"
    }
}

struct Item: Codable {
    let description: String
    var products: [Product]?
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case products = "Products"
    }
}
