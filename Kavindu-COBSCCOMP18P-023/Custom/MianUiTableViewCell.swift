//
//  MianUiTableViewCell.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by kevn shayn on 2/29/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit


protocol MianUiTableViewCellDelegate: class {
    func commengtBtnTapped(cell: MianUiTableViewCell)
}
class MianUiTableViewCell:UITableViewCell{
    
    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var goingLbl: UILabel!
    
    @IBOutlet weak var commentBtn: UIButton!
    weak var delegate: MianUiTableViewCellDelegate?
    
    @IBOutlet weak var goingStackView: UIStackView!
    
    var data:Event! {
        didSet {
            self.updateUI(with: self.data)
        }
    }
    
    @IBAction func commengtBtnTapped(_ sender: Any) {
        
        delegate?.commengtBtnTapped(cell: self)
    }
    
    private func updateUI(with data:Event) {
        titleLbl.text = data.title
        startDateLbl.text = data.startingdate
        
        if let imageUrl = data.displayImageUrl{
            let url=URL(string: imageUrl)
            EventImage.kf.setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        
        EventImage?.layer.cornerRadius=10;
        EventImage?.clipsToBounds=true;
        commentBtn.layer.borderColor=UIColor.black.cgColor
        commentBtn.layer.borderWidth=0.0
        
      //  commentBtn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
      //  commentBtn.layer.cornerRadius = 30
        
       // commentBtn.clipsToBounds = true
        commentBtn.backgroundColor = .white
        let SWFrame=goingStackView.frame
        guard let suView=superview else{return}
        
        
//        commentBtn.heightAnchor.constraint(equalTo: commentBtn.heightAnchor, constant: 20)
//        commentBtn.widthAnchor.constraint(equalTo: commentBtn.widthAnchor, constant: 20)
//        commentBtn.leadingAnchor.constraint(equalTo: suView.trailingAnchor, constant: SWFrame.width-150).isActive=true
//
//        goingLbl.leadingAnchor.constraint(equalTo: goingLbl.trailingAnchor, constant: 10).isActive=true
//        goingLbl.trailingAnchor.constraint(equalTo: commentBtn.trailingAnchor, constant: 10).isActive=true
        //commentBtn.topAnchor.constraint(equalTo: suView.topAnchor, constant: 10).isActive=true
        //commentBtn.bottomAnchor.constraint(equalTo: suView.bottomAnchor, constant: 10).isActive=true
      //  commentBtn.bottomAnchor.constraint(equalTo: suView.topAnchor, constant: SWFrame.height+10).isActive=true
        //        let origImage = UIImage(named: "verified")
        //        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        //        cell.commentBtn.setImage(tintedImage, for: .normal)
        //        //cell.commentBtn.tintColor = .white
        //        cell.commentBtn.imageView?.tintColor = .white
        //        cell.commentBtn.layer.cornerRadius = 50
        //        cell.commentBtn.layer.borderColor=UIColor.black.cgColor
        //        cell.commentBtn.layer.borderWidth=3.0
        
        // cell.likeBtn.superview?.bringSubviewToFront(cell.EventImage)
        //        cell.textLabel?.text=event.title
        //        cell.detailTextLabel?.text=event.startingdate;
    }
}
