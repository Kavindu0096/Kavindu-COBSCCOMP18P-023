//
//  MainTabController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/5/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    private var homeVC:HomeViewController!
    private var addEventVC:AddEventViewController!
    private var profileVC:ProfileViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

//    private func createTabBar(){
//        homeVC = HomeViewController()
//        homeVC.tabBarItem = UITabBarItem.init(title: "Home", image: nil, tag: 0)
//        
//        addEventVC = AddEventViewController()
//        addEventVC.tabBarItem = UITabBarItem.init(title: "Add Event", image: nil, tag:1)
//        
//        profileVC = ProfileViewController()
//        profileVC.tabBarItem = UITabBarItem.init(title: "Profile", image: nil, tag: 2)
//        
//        self.viewControllers = [homeVC,addEventVC,profileVC]
//    }

}
