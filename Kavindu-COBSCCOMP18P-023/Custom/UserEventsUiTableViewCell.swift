//
//  UserEventsUiTableViewCell.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by kevn shayn on 3/1/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation
import UIKit




class UserEventsUiTableViewCell:UITableViewCell{
    
    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!

    
    @IBOutlet weak var commentBtn: UIButton!
  
    
    @IBOutlet weak var goingStackView: UIStackView!
    
    var data:Event! {
        didSet {
            self.updateUI(with: self.data)
        }
    }
    
    
    private func updateUI(with data:Event) {
        
        guard let startingDate=data.startingdate else {return}
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        guard let now = dateFormatter.date(from: startingDate) else {return}
        dateFormatter.dateFormat = "MMM"
        let nameOfMonth = dateFormatter.string(from: now)
        
        dateFormatter.dateFormat = "dd"
        let dayOfMonth = dateFormatter.string(from: now)
        
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppColors.brown, .font: UIFont.systemFont(ofSize: 27)]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: AppColors.black, .font: UIFont.systemFont(ofSize: 20)]
        
        let firstString = NSMutableAttributedString(string: nameOfMonth, attributes: firstAttributes)
        let secondString = NSAttributedString(string: "\n"+dayOfMonth, attributes: secondAttributes)
        
        firstString.append(secondString)
        
        titleLbl.text = data.title
        startDateLbl.attributedText = firstString
        
        if let imageUrl = data.displayImageUrl{
            let url=URL(string: imageUrl)
            EventImage.kf.setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        
        EventImage?.layer.cornerRadius=10;
        EventImage?.clipsToBounds=true;

        let SWFrame=goingStackView.frame
        guard let suView=superview else{return}
        
        
    }
}
