//
//  LoginController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/4/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var pwTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTxt.text!, password: pwTxt.text!) { (authResult, error ) in
           if error != nil {
                return
            }
            else if authResult==nil{
                return
        }
            else{
                let user=authResult
            }
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
