//
//  Alert.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/9/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation
import UIKit

class Aleret:UIViewController{

//    func showAlert(title:String,message:String) {
//        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
//
//       self.present(alert, animated: true, completion: nil)
//
//    }
    
    
      func showAlert(on vc:UIViewController,title:String,message:String) {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        vc.present(alert, animated: true, completion: nil)
        
    }
}


