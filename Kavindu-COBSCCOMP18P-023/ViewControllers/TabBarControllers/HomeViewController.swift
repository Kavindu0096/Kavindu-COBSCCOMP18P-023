//
//  HomeViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class HomeViewController:UIViewController,MianUiTableViewCellDelegate, UITableViewDelegate,UITableViewDataSource{


    let cellId="cellId"
    var EventList:[Event]=[]
    var selectedEvent:Event!
      var event:Event?
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var eventsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEvents()
       
        
        // Do any additional setup after loading the view.
    }
    

    
    func commengtBtnTapped(cell: MianUiTableViewCell) {
        
        let indexPath = self.eventsTblView.indexPath(for: cell)

        if(EventList[(indexPath?.row)!].going==0 || EventList[(indexPath?.row)!].going==nil){
            let origImage = UIImage(named: "correct")
            cell.commentBtn.setImage(origImage, for: .normal)
            EventList[(indexPath?.row)!].going=1
            cell.goingLbl.textColor=AppColors.lightBlue
        }
        else{
            let origImage = UIImage(named: "verified1")
            cell.commentBtn.setImage(origImage, for: .normal)
            EventList[(indexPath?.row)!].going=0
            cell.goingLbl.textColor=AppColors.black
        }
       
        
     
    }
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
                            var timeStampKey:String?
                            timeStampKey=key
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
                            let event=Event.init(id: idval ?? 0, title: title ?? "",location:location ?? "", displayImageUrl: displayImageUrl ?? "", startingdate: startingdate ?? "",startTime:startTime ?? "",endTime:endTime ?? "", endDate: endDate ?? "", oneDayEvent: oneDayEvent ?? 0, description: description ?? "", oranizedBy: oranizedBy ?? "" ,userKey: userKey ?? "", timeStampKey: timeStampKey ?? "")
                            self.EventList.append(event)
                            self.eventsTblView.reloadData()
                            
                            
                        })
                    })
                }
            }
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MianUiTableViewCell", for: indexPath)
            as! MianUiTableViewCell
        cell.delegate = self
        cell.data = EventList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UpdateDetail", sender:self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier=="UpdateDetail"){
            guard let  indexPath=eventsTblView?.indexPathForSelectedRow else{return}
            
             guard  let data1 = ( eventsTblView.cellForRow(at: indexPath) as? MianUiTableViewCell)?.data else { return }
            
           if let destination = segue.destination as? EventDetailViewController{
                destination.event=data1
            }
            eventsTblView.deselectRow(at: indexPath
                , animated: true)
        }
        
    }
}
