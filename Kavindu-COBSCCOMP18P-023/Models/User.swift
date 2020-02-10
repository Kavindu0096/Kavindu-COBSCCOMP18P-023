//
//  User.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/9/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation

struct User:Hashable{
    
    var email:String
    var userName:String
    
    init(Email:String,UserName:String){
        
        self.email=Email
        self.userName=UserName
    }
    var asDictinary:[String:Any]{
        return[
            "email":email,
            "userName":userName
        ]
    }
    
}
