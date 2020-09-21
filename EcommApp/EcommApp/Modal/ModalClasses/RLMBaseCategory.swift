//
//  RLMBaseCategory.swift
//  EcommApp
//
//  Created by apple on 18/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

import RealmSwift
import Realm

class RLMBaseCategory: Object, Decodable {
   
    let categories = List<rlmCategory>()
    let rankings = List<rlmRanking>()
    
    private enum CodingKeys: String, CodingKey {
        //case id
        case categories = "categories"
        case rankings = "rankings"
        //case child_categories
    }
    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        // Map your JSON Array response
//        let catlist = try container.decodeIfPresent([rlmCategory].self, forKey: .categories) ?? [rlmCategory()]
//        categories.append(objectsIn: catlist)
//
//        let ranklist = try container.decodeIfPresent([rlmRanking].self, forKey: .rankings) ?? [rlmRanking()]
//        rankings.append(objectsIn: ranklist)
//
//    }
}

class rlmCategory: Object, Decodable {
   
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    let products = List<rlmProduct>()
    var child_categories = List<String>()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case products
        case child_categories
    }
}

//2 Product
class rlmProduct: Object, Decodable {
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var date_added: String?
    let variant = List<rlmVariant>()
    @objc dynamic var tax: rlmTax?
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case date_added
        case variant
        case tax
    }
}


//3 Variant
class rlmVariant: Object, Decodable {
   
    @objc dynamic var id = 0
    @objc dynamic var color: String?
//    dynamic var size: Int!
//    dynamic var price : Int!
//
    @objc dynamic var size = 0
    @objc dynamic var price = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case color
        case size
        case price
    }
}

//4 Tax
class rlmTax: Object, Decodable {
   
    @objc dynamic var id: String?

    @objc dynamic var value = 0.0
    @objc dynamic var name: String?
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case value
        case name
    }
}


//MARK: - Ranking

class rlmRankProduct: Object, Decodable {
   
    @objc dynamic var id = 0
    @objc dynamic var view_count = 0
    @objc dynamic var order_count = 0
    @objc dynamic var shares = 0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case view_count
        case order_count
        case shares
    }
}


class rlmRanking: Object, Decodable {
   
    @objc dynamic var ranking: String?
    let products = List<rlmRankProduct>()
    
    override static func primaryKey() -> String? {
        return "ranking"
    }
    
    private enum CodingKeys: String, CodingKey {
        case ranking
        case products
    }
}


