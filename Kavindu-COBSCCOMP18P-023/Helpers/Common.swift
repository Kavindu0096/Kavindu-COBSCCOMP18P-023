//
//  Common.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/9/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Common :Encodable{
    
    func validateLogin(currentController:UIViewController){
        if Auth.auth().currentUser==nil{
            DispatchQueue.main.async {
                let navController=UINavigationController(rootViewController: LoginController())
                currentController.present(navController,animated: true,completion: nil)
            }
        }
        
    }
    func setUserUid(userUid:Any){
         UserDefaults.standard.set(userUid,forKey: "userUid")
    }

   
    
}
