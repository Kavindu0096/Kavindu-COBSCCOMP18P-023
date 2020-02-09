//
//  User.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/9/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation

struct User:Codable{
    
    var Email:String
    var UserName:String
    
    init(Email:String,UserName:String){
        
        self.Email=Email
        self.UserName=UserName
    }
    
}
