//
//  AddEventDetailViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit
import Firebase

class AddEventDetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var locationTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    
    @IBOutlet weak var endDateTxt: UITextField!
    
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var oraganizedByTxt: UITextField!
    @IBOutlet weak var displayImg: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var publishBtn: UIButton!
    
    let defaults = UserDefaults.standard
    static var eventArray:[Event]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initEvent()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func uploadBtnTapped(_ sender: Any) {
        let imgPickerController=UIImagePickerController()
        imgPickerController.delegate=self;
        imgPickerController.sourceType=UIImagePickerController.SourceType.photoLibrary
        self.present(imgPickerController, animated: true, completion: nil)
        
        
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
        if let data = UserDefaults.standard.object(forKey:"Events") as? Data {
            AddEventDetailViewController.eventArray = try! PropertyListDecoder().decode(Array<Event>.self, from: data)
            //            print(AddEventDetailViewController.eventArray)
            //            print("Count")
            //            print(AddEventDetailViewController.eventArray.count)
        }
        
        
    }
    func addEvent(imgUrl:String){
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let now = Date()
        let maxId=AddEventDetailViewController.eventArray.map({$0.id}).max() ?? 0
        let event = Event.init(
            id: Int(maxId)+1,
            title:titleTxt.text!,
            displayImageUrl:imgUrl ?? "",
            //            startingdate:dateFormatter.date(from:startDateTxt.text!)!,
            //            endDate:dateFormatter.date(from:endDateTxt.text!)!,
            startingdate:now,
            endDate:now,
            oneDayEvent:0,
            description:descriptionTxt.text ?? "",
            oranizedBy:oraganizedByTxt.text ?? ""
        )
        AddEventDetailViewController.eventArray.append(event)
        let er=try? PropertyListEncoder().encode(AddEventDetailViewController.eventArray)
        
        defaults.set(er ,forKey: "Events")
        
    }
    
    
    @IBAction func publishBtnTapped(_ sender: Any) {
        
        //let data = Data()
        let storageRef = Storage.storage().reference()
        let imagesRef = storageRef.child("1.png")
        let uploadData = displayImg.image?.pngData()
//            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
//                guard metadata != nil else {
//                    print(" Adding Error")
//                    print(error ??  "")
//                    return
//                }
//                imagesRef.downloadURL { (url, error2) in
//                    guard let downloadURL = url else {
//                        print(" Adding Error1")
//                        print(error2 ?? "")
//                        return
//                    }
//
//                    self.addEvent(imgUrl: downloadURL.path)
//
//                }
//            }
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
                 self.addEvent(imgUrl: downloadURL.path)
            }
        }
        
    }
    
}
