//
//  SignUpController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/4/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var rePasswordTxt: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func  validate() -> Bool {
       
         let alert = Aleret()
        if emailTxt.text == nil || userNameTxt.text == nil || passwordTxt.text == nil || rePasswordTxt.text == nil{
            alert.showAlert(title: "Invalid Fields", message: "Please fill all fields")
            return false
        }
        if passwordTxt.text != rePasswordTxt.text{
               alert.showAlert(title: "Invalid Fields", message: "Re-Passowrd don't  match")
            return false
        }
        return true
    }
    
    
    func createUder(){
        
        if validate() {
        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (result,error) in
            
            if let error=error{
                print(error)
                return
            }
            guard let uId=result?.user.uid else {return}
            
            var user=User.init(Email:self.emailTxt.text!,UserName:self.userNameTxt.text!)
            
           
            
            
            }
            
            
        }
    }

    @IBAction func signUpBtnTapped(_ sender: Any) {
    }
}
