//
//  PersonModel.swift
//  DataBase
//
//  Created by HeMu on 05/07/17.
//  Copyright © 2017 HeMu. All rights reserved.
//

import UIKit

class PersonModel: NSObject {

    var person_id   : String?
    var person_Fname : String?
    var person_Lname : String?
    var person_city  : String?
    var person_address : String?
    
    
    init(person_id : String,person_Fname : String,person_Lname : String,person_city  : String,person_address : String) {
        self.person_id    = person_id
        self.person_Fname = person_Fname
        self.person_Lname = person_Lname
        self.person_city = person_city
        self.person_address = person_address
    }
    
}
