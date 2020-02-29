//
//  MianUiTableViewCell.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by kevn shayn on 2/29/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import UIKit


protocol MianUiTableViewCellDelegate: AnyObject {
    func commengtBtnTapped(cell: MianUiTableViewCell)
}
class MianUiTableViewCell:UITableViewCell{
    
    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var commentBtn: UIButton!
    weak var delegate: MianUiTableViewCellDelegate?
    
    @IBAction func commengtBtnTapped(_ sender: Any) {
        
        delegate?.commengtBtnTapped(cell: self)
    }
    
    override func layoutSubviews() {
        
        EventImage?.layer.cornerRadius=10;
        EventImage?.clipsToBounds=true;
        commentBtn.layer.borderColor=UIColor.black.cgColor
        commentBtn.layer.borderWidth=0.0
        
        commentBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        commentBtn.layer.cornerRadius = 20
        commentBtn.clipsToBounds = true
        commentBtn.backgroundColor = .white
        
        
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
