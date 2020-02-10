//
//  AddEventViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase

class AddEventViewController: UIViewController {

    let common=Common()
    override func viewDidLoad() {
       
        validateLogin()
       
    }
//    override func viewDidAppear(_ animated: Bool) {
//       // validateLogin()
//    }
    func validateLogin(){
        if Auth.auth().currentUser==nil{
         
            let loginSB=UIStoryboard(name: "Login", bundle: Bundle.main)
            guard let loginVC=loginSB.instantiateViewController(withIdentifier: "LoginController") as? LoginController  else {return}
            self.present(loginVC, animated: true, completion:nil)
        }
        else {
             super.viewDidLoad()
            guard let uId=Auth.auth().currentUser?.uid else{return}
            common.setUserUid(userUid: uId)
           
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
