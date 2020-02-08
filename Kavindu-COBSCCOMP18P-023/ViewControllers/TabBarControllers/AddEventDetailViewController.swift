//
//  AddEventDetailViewController.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/6/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit

class AddEventDetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var displayImg: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
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
       
       // displayImg.image=info[UIImagePickerController]
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){}

}
