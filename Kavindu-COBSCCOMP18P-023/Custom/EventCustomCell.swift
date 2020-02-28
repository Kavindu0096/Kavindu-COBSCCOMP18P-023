//
//  EventCustomCell.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by kevn shayn on 2/26/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation
import UIKit
class EventCustomCell:UITableViewCell{
    
    var title:String?
    var eventImage:UIImage?
    
    var titleView : UITextView = {
        var textView=UITextView()
        textView.translatesAutoresizingMaskIntoConstraints=false
        return textView
    }()
    
    
    var eventImageView :UIImageView={
        var imageView = UIImageView();
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(eventImageView)
        self.addSubview(titleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
