//
//  BaseCategory.swift
//  EcommApp
//
//  Created by apple on 18/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

// MARK: - BaseCategory //0
struct BaseCategory: Codable {
    var categories: [Category]
    var rankings: [Ranking]
}

// MARK: - Category //1
struct Category: Codable{
    let id: Int
    let name: String
    var products: [CategoryProduct]
    var childCategories: [Int]

    enum CodingKeys: String, CodingKey {
        case id, name, products
        case childCategories = "child_categories"
    }
}

// MARK: - CategoryProduct//2
struct CategoryProduct: Codable {
    let id: Int
    let name, dateAdded: String
    var variants: [Variant]
    let tax: Tax

    enum CodingKeys: String, CodingKey {
        case id, name
        case dateAdded = "date_added"
        case variants, tax
    }
}

// MARK: - Tax//3
struct Tax: Codable {
    let name: Name
    let value: Double
}

//4
enum Name: String, Codable {
    case vat = "VAT"
    case vat4 = "VAT4"
}

// MARK: - Variant//5
struct Variant: Codable {
    let id: Int
    let color: String
    let size: Int?
    let price: Int
}

// MARK: - Ranking//6
struct Ranking: Codable {
    let ranking: String
    let products: [RankingProduct]
}

// MARK: - RankingProduct//7
struct RankingProduct: Codable {
    let id: Int
    let viewCount, orderCount, shares: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shares
    }
}
// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
