//
//  ProfileViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var signoutBtn: UIButton!
    @IBOutlet weak var profileTabBarItem: UITabBarItem!
    let common=Common()
    override func viewDidLoad() {
        
        validateLogin()
        // Do any additional setup after loading the view.
    }
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

    @IBAction func signoutBtnTapped(_ sender: Any) {
        if Auth.auth().currentUser==nil{
            print ("Empty User" )
            return}
        else{
            
            do {
                try Auth.auth().signOut()
                let mainSB=UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let mainVC=mainSB.instantiateViewController(withIdentifier: "MainTabController") as? MainTabController  else {return}
                self.present(mainVC, animated: true, completion:nil)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    

}
