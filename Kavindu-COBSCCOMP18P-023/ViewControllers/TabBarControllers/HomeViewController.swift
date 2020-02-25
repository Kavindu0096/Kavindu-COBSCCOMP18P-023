//
//  HomeViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController:UIViewController, UITableViewDelegate,UITableViewDataSource{


     let cellId="cellId"
    let EventVal=[Event]()
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEvents()
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
 
//    @IBAction func loginBtnTapped(_ sender: Any) {
//        let loginSB=UIStoryboard(name: "Login", bundle: Bundle.main)
//
//        guard let loginVC=loginSB.instantiateViewController(withIdentifier: "LoginController") as? LoginController else{
//            return
//        }
//        present(loginVC, animated: true, completion: nil)
//    }
//
    
    func fetchEvents(){
        
        Database.database().reference().child("Events").observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                if let dictionary:[String:AnyObject]=snapshot.value as? [String:AnyObject]{
                   // print(dictionary)
                     print(dictionary["value"])
                    dictionary.values.forEach({ (vals) in
                        let events=vals as? [String:AnyObject]
                        events?.forEach({ (key, value) in
                              let eventObj=value as? Event
                           // var objCMutableArray = NSMutableArray(array: value)
                          //  var swiftArray = objCMutableArray as NSArray as [String];
                            print(key)
                               print(value)
                        })
                    })
//                    dictionary.forEach({ (key, value) in
//
//                        let post = value
////                        post?.forEach({ (eventkey, eventVal) in
////                            let eventObj = Event.init(
////                                                    id:0,
////                                                    title:eventVal["title"] as! String,
////                                                    displayImageUrl:eventVal["displayImageUrl"] as! String,
////                                                    startingdate:eventVal["startingdate"]as! String,
////                                                    endDate:eventVal["endDate"]as! String,
////                                                    oneDayEvent:1,
////                                                    description:eventVal["description"]as! String,
////                                                    oranizedBy:eventVal["oranizedBy"]as! String
////                                                )
////                        })
//
//                    })
                  
//                    let event = Event.init(
//                        id:0,
//                        title:dictionary["title"] as! String,
//                        displayImageUrl:dictionary["displayImageUrl"] as! String,
//                        startingdate:dictionary["startingdate"]as! String,
//                        endDate:dictionary["endDate"]as! String,
//                        oneDayEvent:1,
//                        description:dictionary["description"]as! String,
//                        oranizedBy:dictionary["oranizedBy"]as! String
//                    )
                }
            }
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text="sdsdsssd"
        return cell
    }
}
