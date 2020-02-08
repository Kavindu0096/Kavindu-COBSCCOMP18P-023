//
//  Event.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/8/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation

struct Event:Codable{
    var title:String?
    var startingdate:Date?
    var endDate:Date?
    var oneDayEvent:boolean_t?
    var description:String?
    var oranizedBy:String?
    
    init(title:String,startingdate:Date,endDate:Date,oneDayEvent:boolean_t,description:String,oranizedBy:String) {
        self.title=title
        self.startingdate=startingdate
        self.endDate=endDate
        self.oneDayEvent=oneDayEvent
        self.description=description
        self.oranizedBy=oranizedBy
    }
    
}
