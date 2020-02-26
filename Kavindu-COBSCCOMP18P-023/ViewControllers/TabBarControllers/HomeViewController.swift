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
    
    static var EventList:[Event]=[]
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var eventsTblView: UITableView!
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
             
                if let dictionary=snapshot.value as? [String:AnyObject]{
                    dictionary.values.forEach({ (vals) in
                        guard let eventsvals = vals as? [String:[String:AnyObject]] else { return }
                       
                        eventsvals.forEach({ (key, value) in
                            guard let valueDic = value as? [String:Any] else { return }
                            
                            var idval:Int?
                            var title:String?
                            var startingdate:String?
                            var endDate:String?
                            var displayImageUrl:String?
                            var oneDayEvent:boolean_t?
                            var description:String?
                            var oranizedBy:String?
                            
                            for valueD in valueDic{
                                
                               
                                if valueD.key == "id" {
                                    print(valueD.value)
                                }

                                
                                if valueD.key == "id" {
                                    
                                    idval = Int(  valueD.value as? String ?? "o") ??  0
                                }
                                if valueD.key == "title" {
                                    
                                    title = valueD.value as? String ?? ""
                                }
                                if valueD.key == "startingdate" {
                                    
                                    startingdate = valueD.value as? String ?? ""
                                }
                                if valueD.key == "endDate" {
                                    
                                    endDate = valueD.value as? String ?? ""
                                }
                                if valueD.key == "displayImageUrl" {
                                    
                                    displayImageUrl = valueD.value as? String ?? ""
                                }
                                if valueD.key == "oneDayEvent" {
                                    let Oday = Int(  valueD.value as? String ?? "o") ??  0
                                    oneDayEvent = boolean_t( Oday)
                                }
                                if valueD.key == "description" {
                                    
                                    description = valueD.value as? String ?? ""
                                }
                                if valueD.key == "oranizedBy" {
                                    
                                    oranizedBy = valueD.value as? String ?? ""
                                }
                               
                                
                            }
                            let event=Event.init(id: idval ?? 0, title: title ?? "", displayImageUrl: displayImageUrl ?? "", startingdate: startingdate ?? "", endDate: endDate ?? "", oneDayEvent: oneDayEvent ?? 0, description: description ?? "", oranizedBy: oranizedBy ?? "")
                            HomeViewController.EventList.append(event)
                            self.eventsTblView.reloadData()
                            
                            
                        })
                    })
                }
            }
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewController.EventList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let event=HomeViewController.EventList[indexPath.row]
        cell.textLabel?.text=event.title
        cell.detailTextLabel?.text=event.startingdate;
        if let imageUrl=event.displayImageUrl{
            let url=NSURL(string: imageUrl)
            let storageRef = Storage.storage().reference()
            let imageRef = storageRef.child(String(event.displayImageUrl ?? "") )
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                } else {
                    // Data for "images/island.jpg" is returned
                    cell.imageView?.image  = UIImage(data: data!)
                }
            }
            
        }
        return cell
    }
}
