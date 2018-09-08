//
//  Person.swift
//  HitList
//
//  Created by Sonia Wadji on 14/08/18.
//  Copyright © 2018 genora. All rights reserved.
//

import UIKit

class PersonModel: NSObject {

    var name: String
    var age: Int
    var phoneNumber: String
    
    init(name: String, age: Int, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}
