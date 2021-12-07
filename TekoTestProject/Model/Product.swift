//
//  Product.swift
//  TekoTestProject
//
//  Created by Nguyen Tan Dung on 11/29/21.
//

import Foundation

struct Product : Decodable {
    var id : Int?
    var errorDescription : String?
    var name : String?
    var sku : String?
    var image : String?
    var color : Int?
    
}
