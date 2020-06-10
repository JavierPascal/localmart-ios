//
//  User.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 10/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import Foundation

class User: Codable{
    var uid: String
    var name: String
    var lastname: String
    var email: String
    var phone: String
    var communities: [String]
    
    init(uid: String, name: String, lastname: String, email: String, phone: String, communities: [String]){
        self.uid = uid
        self.name = name
        self.lastname = lastname
        self.email = email
        self.phone = phone
        self.communities = communities
    }
}

