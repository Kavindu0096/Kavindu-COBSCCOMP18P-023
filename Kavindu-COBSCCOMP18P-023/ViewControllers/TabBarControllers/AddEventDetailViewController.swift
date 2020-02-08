//
//  AddEventDetailViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit


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
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){}
    func initEvent(){
        //let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
        if let data = UserDefaults.standard.object(forKey:"Events") as? Data {
            AddEventDetailViewController.eventArray = try! PropertyListDecoder().decode(Array<Event>.self, from: data) ?? []
          
            print("Count")
            print(AddEventDetailViewController.eventArray.count)
        }
        
 
    }
    
    @IBAction func publishBtnTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let now = Date()
        let event = Event.init(
            title:titleTxt.text!,
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

        
        
//        let array1 = ["Hello", "World"]
//        defaults.set(array1, forKey: "SavedArray")
//        defaults.synchronize()
        
       
       initEvent()
        
    }
    
}
