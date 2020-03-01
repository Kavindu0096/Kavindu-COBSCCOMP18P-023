//
//  AddEventDetailViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class AddEventDetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var locationTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var endDateTxt: UITextField!
    
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var oraganizedByTxt: UITextField!
    @IBOutlet weak var displayImg: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var oneDayEventSwitch: UISwitch!
    
    let defaults = UserDefaults.standard
    static var eventArray:[Event]=[]
  
    let common=Common()
    override func viewDidLoad() {
        super.viewDidLoad()
        initEvent()
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.displayImg.image = image
        
        displayImg.backgroundColor=UIColor.clear
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        dismiss(animated: true, completion: nil)
    }
    func initEvent(){
        titleTxt.text = ""
        locationTxt.text = ""
        descriptionTxt.text = ""
        oraganizedByTxt.text = ""
        displayImg.image = nil

        startDatePicker.minimumDate=Date()
        endDatePicker.minimumDate=Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH.mm"
        guard let sdate = dateFormatter.date(from: "9.00") else {return}
        guard let edate = dateFormatter.date(from: "17.30") else {return}
        startTimePicker.date = sdate
        endDatePicker.date = edate
        
        if let data = UserDefaults.standard.object(forKey:"Events") as? Data {
            AddEventDetailViewController.eventArray = try! PropertyListDecoder().decode(Array<Event>.self, from: data)
            
        }
        
       
        
        
    }
    @IBAction func publishBtnTapped(_ sender: Any) {
        
        
        if(validateData()){
            let maxId=(AddEventDetailViewController.eventArray.map({$0.id}).max() ?? 0)+1
            let storageRef = Storage.storage().reference()
            let imageName = String(maxId.description)+","+".png";
            let imagesRef = storageRef.child(imageName)
            let uploadData = displayImg.image?.pngData()
            
            let metaData=StorageMetadata()
            metaData.contentType="image/png"
            
            
            imagesRef.putData(uploadData!, metadata: metaData) { (metadata, error) in
                if let error=error{
                    print(" Adding Error")
                    print(error )
                    return
                }
                
                
                imagesRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print(" Adding Error1")
                        print(error ?? "")
                        return
                    }
                    self.addEvent(imgUrl: downloadURL.description)
                }
            }
        }
    }
    
    @IBAction func onedayEventSwitchvalueChanged(_ sender: Any) {
        if oneDayEventSwitch.isOn{
            endDatePicker.isEnabled=false
        }
        else{
            endDatePicker.isEnabled=true
        }
    }
    func addEvent(imgUrl:String){
        
        let scomponents = Calendar.current.dateComponents([.hour, .minute], from: startTimePicker.date
        )
        
        let shour = scomponents.hour!
         let sminute = scomponents.minute ?? 00
        let sTime=String(shour)+"."+String(sminute)
        
        let ecomponents = Calendar.current.dateComponents([.hour, .minute], from: endDatePicker.date
        )
        
        let ehour = ecomponents.hour!
         let eminute = ecomponents.minute ?? 30
         let eTime=String(ehour)+"."+String(eminute)
         let now = Date()
        let maxId=AddEventDetailViewController.eventArray.map({$0.id}).max() ?? 0
      //  guard let startDate = startDatePicker.date else{ return Date.}
        let endDate=oneDayEventSwitch.isOn ? startDatePicker.date : endDatePicker.date;
        let event = Event.init(
            id: Int(maxId)+1,
            title:titleTxt.text!,
            location: locationTxt.text!,
            displayImageUrl:imgUrl ,
            //            startingdate:dateFormatter.date(from:startDateTxt.text!)!,
            //            endDate:dateFormatter.date(from:endDateTxt.text!)!,
            startingdate:String(startDatePicker?.date.description ?? now.description) ,
            startTime:sTime,
            endTime:eTime,
            endDate:String(endDate.description) ,
            oneDayEvent:oneDayEventSwitch.isOn ? 1 :  0,
            description:descriptionTxt.text ?? "",
            oranizedBy:oraganizedByTxt.text ?? ""
        )
         let userUid=common.getUserUid()
        if userUid != "" {
            
            Database.database().reference().child("Events").child(userUid).child(String(now.description)).setValue(event.asDictinary) {
                (error:Error?, ref:DatabaseReference) in
                if error != nil {
                    let alert = UIAlertController(title:"Error Occurd", message: "Error Occurd when saving record", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alert, animated: true, completion: nil)
                } else {
                   
                    let alert = UIAlertController(title:"Record Saved", message: "Record Saved Successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    self.initEvent()
                }
            }
        }
        
        AddEventDetailViewController.eventArray.append(event)
        let er=try? PropertyListEncoder().encode(AddEventDetailViewController.eventArray)
        
        defaults.set(er ,forKey: "Events")
        
    }
    
    /// MARK-: Actions
    @IBAction func uploadBtnTapped(_ sender: Any) {
        let imgPickerController=UIImagePickerController()
        imgPickerController.delegate=self;
        imgPickerController.sourceType=UIImagePickerController.SourceType.photoLibrary
        self.present(imgPickerController, animated: true, completion: nil)
        
        
    }
    func validateData() -> Bool{
        if(titleTxt.text=="" || locationTxt.text=="" || descriptionTxt.text=="" || oraganizedByTxt.text == "" || displayImg.image==nil){
            let alert = UIAlertController(title:"Incomplete Data", message: "Please fill missing fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        else{return true}
    }
    

    
}
