//
//  Product.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import Foundation

struct Product: Codable {
    let barcode: String
    let imageUrl: String?
    let description: String?
    let price: String?
    enum CodingKeys: String, CodingKey {
        case barcode = "Barcode";
        case imageUrl = "ImageURL"
        case description = "Description"
        case price = "Price"
    }
}
