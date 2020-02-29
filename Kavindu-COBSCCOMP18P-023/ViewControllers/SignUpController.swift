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
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLbl.text="Let's\nget started"
        // Do any additional setup after loading the view.
    }
    
    func  validate() -> Bool {
        
        let alert = Aleret()
        if emailTxt.text == nil || userNameTxt.text == nil || passwordTxt.text == nil || rePasswordTxt.text == nil{
          //  alert.showAlert(title: "Invalid Fields", message: "Please fill all fields")
            return false
        }
        if passwordTxt.text != rePasswordTxt.text{
           // alert.showAlert(title: "Invalid Fields", message: "Re-Passowrd don't  match")
            return false
        }
        return true
    }
    
    
    func createUser(){
        
        if validate() {
            Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (result,error) in
                
                if let error=error{
                    print("Error!!!!!")
                    print(error)
                    return
                }
                guard let uId=result?.user.uid else {return}
                
                let user=User.init(Email:self.emailTxt.text!,UserName:self.userNameTxt.text!).asDictinary
                
                //            var ref: DatabaseReference!
                //            ref = Database.database().reference()
                //            Database.database().reference().child("Users").child(uId).setValue(user, withCompletionBlock: { (error, ref) in
                //                if let error=error{
                //                    print(error)
                //                    return
                //                }
                //                 print("Data Saved")
                //            }
                
                
             //   let userDict=["email": self.emailTxt.text!,"userName":self.userNameTxt.text!]
                Database.database().reference().child("Users").child(uId).setValue(user) {
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                    } else {
                        print("Data saved successfully!")
                    }
                }
                
            }
            
            
        }
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        createUser()
    }
    @IBAction func dismissBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
}
