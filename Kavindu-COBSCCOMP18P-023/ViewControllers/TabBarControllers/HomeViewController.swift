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
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var eventsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEvents()
       
        
        // Do any additional setup after loading the view.
    }
    
    func ajustCell(){
        
      
    }
    
    func commengtBtnTapped(cell: MianUiTableViewCell) {
        
        let indexPath = self.eventsTblView.indexPath(for: cell)
        print(indexPath!.row)
        
        let origImage = UIImage(named: "check2")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        cell.commentBtn.setImage(tintedImage, for: .selected)
        cell.commentBtn.backgroundColor = .blue
        
     
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
        let event=EventList[indexPath.row]
        cell.titleLbl?.text=event.title
        cell.startDateLbl?.text=event.startingdate
        
        if let imageUrl=event.displayImageUrl{
            let url=URL(string: imageUrl)
            cell.EventImage?.kf.setImage(with: url)
           

            
        }
        return cell
    }
}
