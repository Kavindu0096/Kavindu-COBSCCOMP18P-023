//
//  HomeViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    @IBAction func loginBtnTapped(_ sender: Any) {
        let loginSB=UIStoryboard(name: "Login", bundle: Bundle.main)
        
        guard let loginVC=loginSB.instantiateViewController(withIdentifier: "LoginController") as? LoginController else{
            return
        }
        present(loginVC, animated: true, completion: nil)
    }
    
}
