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

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    let common=Common()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        //let alert = Aleret()
    
        Auth.auth().signIn(withEmail: emailTxt.text!, password: pwTxt.text!) { (authResult, error ) in
           if error != nil {
                //alert.showAlert(on: loginC, title: "Login Failed", message: "Please enter valid credential")
                let alert = UIAlertController(title:"Login Failed", message: "Please Enter Valid Credential", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alert, animated: true, completion: nil)
            
                return
            }
            else if authResult==nil{
                let alert = UIAlertController(title:"Login Failed", message: "Invalid User", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alert, animated: true, completion: nil)
                return
           }
            else{
               
            guard let uId=authResult?.user.uid else{return}
            self.common.setUserUid(userUid: uId)
            let mainSB=UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let mainVC=mainSB.instantiateViewController(withIdentifier: "MainTabController") as? MainTabController else{return}
            self.present(mainVC, animated: true, completion: nil)
            
            }
    }
    }
  
    
    // MARK: - Navigation

    
    @IBAction func backNavBtnTapped(_ sender: Any) {
        let loginSB=UIStoryboard(name: "Login", bundle: Bundle.main)
        
        guard let loginVC=loginSB.instantiateViewController(withIdentifier: "LoginController") as? LoginController else{
            return
        }
        present(loginVC, animated: true, completion: nil)
    }
    
    
    @IBAction func registerBtnTapped(_ sender: Any) {}

        
    @IBAction func backBtnTapped(_ sender: Any) {
        
        let mainSB=UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainVC=mainSB.instantiateViewController(withIdentifier: "MainTabController") as? MainTabController else{
            return
        }
        mainVC.modalTransitionStyle=UIModalTransitionStyle.partialCurl
        present(mainVC, animated: true, completion: nil)
    }
    
    
}
    
    

