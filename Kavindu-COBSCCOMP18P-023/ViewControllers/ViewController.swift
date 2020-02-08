//
//  ViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/4/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    enum Tabs:Int{
        case DashBord
        case Middle
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    func load(){
      //  let tabBarController = storyboard?.instantiateInitialViewController(withIdentifier: "MainTabController") as? MainTabController
        
      //  tabBarController.selectedViewController=tabBarController.viewControllers?[Tabs.Middle.rawValue]
    }


}

