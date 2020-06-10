//
//  Product.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 10/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import Foundation

class Product: Codable{
    var name: String
    var description: String
    var image: String
    var price: String
    var seller: String
    var sold: Bool
    
    init(name: String, description: String, image: String, price: String, seller: String, sold: Bool){
        self.name = name
        self.description = description
        self.image = image
        self.price = price
        self.seller = seller
        self.sold = sold
    }
}

