//
//  Event.swift
//  Kavindu-COBSCCOMP18P-023
//
//  Created by Yasith Thathsara Senarathne on 2/8/20.
//  Copyright © 2020 Kavindu Nimsara. All rights reserved.
//

import Foundation

struct Event:Codable{
    var id:Int
    var title:String?
    var startingdate:Date?
    var endDate:Date?
    var displayImageUrl:String?
    var oneDayEvent:boolean_t?
    var description:String?
    var oranizedBy:String?
    
    init(id:Int,title:String,displayImageUrl:String,startingdate:Date,endDate:Date,oneDayEvent:boolean_t,description:String,oranizedBy:String) {
        self.id=id
        self.title=title
        self.displayImageUrl=displayImageUrl
        self.startingdate=startingdate
        self.endDate=endDate
        self.oneDayEvent=oneDayEvent
        self.description=description
        self.oranizedBy=oranizedBy
    }
    
}
