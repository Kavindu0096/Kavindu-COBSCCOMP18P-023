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

class MianUiTableViewCell:UITableViewCell{
    
    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel! 
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBAction func commengtBtnTapped(_ sender: Any) {
        let origImage = UIImage(named: "verified")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        commentBtn.setImage(tintedImage, for: .normal)
        commentBtn.backgroundColor = .blue
    }
}

class HomeViewController:UIViewController, UITableViewDelegate,UITableViewDataSource{


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
        //let cell=UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
            as! MianUiTableViewCell
        let event=EventList[indexPath.row]
        cell.titleLbl?.text=event.title
        cell.startDateLbl?.text=event.startingdate;
        cell.commentBtn.layer.cornerRadius = 60
        cell.commentBtn.layer.borderColor=UIColor.black.cgColor
        cell.commentBtn.layer.borderWidth=3.0
        cell.commentBtn.backgroundColor = .white
        cell.commentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        cell.commentBtn.imageView?.layer.cornerRadius = cell.commentBtn.bounds.height/2.0
        
//        cell.commentBtn.layer.cornerRadius = 50
//        cell.commentBtn.layer.borderColor=UIColor.black.cgColor
//        cell.commentBtn.layer.borderWidth=3.0
        
       // cell.likeBtn.superview?.bringSubviewToFront(cell.EventImage)
//        cell.textLabel?.text=event.title
//        cell.detailTextLabel?.text=event.startingdate;
        
        if let imageUrl=event.displayImageUrl{
            let url=URL(string: imageUrl)
            let processor = RoundCornerImageProcessor(cornerRadius: 20)
           // cell.imageView?.kf.setImage(with: url)
            cell.EventImage?.kf.setImage(with: url)
            cell.EventImage?.layer.cornerRadius=10;
            cell.EventImage?.clipsToBounds=true;

            
        }
        return cell
    }
}
