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
    var location:String?
    var startingdate:String?
    var startTime:String?
    var endTime:String?
    var endDate:String?
    var displayImageUrl:String?
    var oneDayEvent:boolean_t?
    var description:String?
    var oranizedBy:String?
    var going:boolean_t?
    
    var userKey:String?
    var timeStampKey:String?
    init(id:Int,title:String,location:String,displayImageUrl:String,startingdate:String,startTime:String?,endTime:String?,endDate:String,oneDayEvent:boolean_t,description:String,oranizedBy:String, userKey:String,timeStampKey:String) {
        self.id=id
        self.title=title
        self.displayImageUrl=displayImageUrl
        self.startingdate=startingdate
        self.startTime=startTime
        self.endTime=endTime
        self.endDate=endDate
        self.oneDayEvent=oneDayEvent
        self.description=description
        self.oranizedBy=oranizedBy
        self.userKey=userKey
        self.timeStampKey=timeStampKey
    }
    
    var asDictinary:[String:Any]{
        return[
            "id":id,
            "title":title ?? "",
            "location":location ?? "",
            "displayImageUrl":displayImageUrl  ?? "",
            "startingdate":startingdate  ?? "",
            "startTime":startTime ?? "",
            "endTime":endTime ?? "",
            "endDate":endDate  ?? "",
            "oneDayEvent":oneDayEvent  ?? "",
            "description":description  ?? "",
            "oranizedBy":oranizedBy  ?? "",
            "userKey":userKey ?? "",
            "timeStampKey":timeStampKey ?? "",
        ]
    }
}
