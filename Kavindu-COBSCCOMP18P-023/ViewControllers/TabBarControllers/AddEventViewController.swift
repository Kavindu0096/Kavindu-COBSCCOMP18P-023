//
//  AddEventViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase

class AddEventViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   

    @IBOutlet weak var eventsTblView: UITableView!
    let common=Common()
    var EventList:[Event]=[]
    var selectedEvent:Event!
    var event:Event?
    override func viewDidLoad() {
       
        validateLogin()
        fetchEvents()
       
    }
//    override func viewDidAppear(_ animated: Bool) {
//       // validateLogin()
//    }
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
    
    func fetchEvents(){
        guard let uId=Auth.auth().currentUser?.uid else{return}
        Database.database().reference().child("Events").child(uId).observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                
                if let dictionary=snapshot.value as? [String:AnyObject]{
                    dictionary.values.forEach({ (vals) in
                        guard let eventsvals = vals as? [String:AnyObject] else { return }
                        
                            
                            var idval:Int?
                            var title:String?
                            var location:String?
                            var startingdate:String?
                            var startTime:String?
                            var endTime:String?
                            var endDate:String?
                            var displayImageUrl:String?
                            var oneDayEvent:boolean_t?
                            var description:String?
                            var oranizedBy:String?
                        
                        var userKey:String?
                        var timeStampkey:String?
                        userKey=""
                        timeStampkey=""
                            for valueD in eventsvals{
                                
                                
                                if valueD.key == "id" {
                                    print(valueD.value)
                                }
                                
                                
                                if valueD.key == "id" {
                                    
                                    idval = Int(  valueD.value as? String ?? "o") ??  0
                                }
                                if valueD.key == "title" {
                                    
                                    title = valueD.value as? String ?? ""
                                }
                                if valueD.key == "location" {
                                    
                                    location = valueD.value as? String ?? ""
                                }
                                if valueD.key == "startingdate" {
                                    
                                    startingdate = valueD.value as? String ?? ""
                                }
                                if valueD.key == "startTime" {
                                    
                                    startTime = valueD.value as? String ?? ""
                                }
                                if valueD.key == "endTime" {
                                    
                                    endTime = valueD.value as? String ?? ""
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
                    let event=Event.init(id: idval ?? 0, title: title ?? "",location:location ?? "", displayImageUrl: displayImageUrl ?? "", startingdate: startingdate ?? "",startTime:startTime ?? "",endTime:endTime ?? "", endDate: endDate ?? "", oneDayEvent: oneDayEvent ?? 0, description: description ?? "", oranizedBy: oranizedBy ?? "" , userKey:userKey ?? "",timeStampKey: timeStampkey ?? "" )
                            self.EventList.append(event)
                    
                        })
                }
                
                DispatchQueue.main.async {
                    self.eventsTblView.reloadData()
                }
            }
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserEventUITableViewCell", for: indexPath)
            as! UserEventUITableViewCell
       
        cell.data = EventList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UpdateDetail", sender:self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier=="UpdateDetail"){
            guard let  indexPath=eventsTblView?.indexPathForSelectedRow else{return}
            
            guard  let data1 = ( eventsTblView.cellForRow(at: indexPath) as? UserEventUITableViewCell)?.data else { return }
            
            if let destination = segue.destination as? AddEventDetailViewController{
                destination.event=data1
            }
            eventsTblView.deselectRow(at: indexPath
                , animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
           // tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            //tableView.reloadData()
            EventList.remove(at: indexPath.row)
           // self.catNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            
        }
    }

}
