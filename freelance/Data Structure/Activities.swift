//
//  Activities.swift
//  Activities
//
//  Created by James Ryu on 2021-09-01.
//

import Foundation

func makeSmallActivities(dict: [[String:Any]]) -> [SmallActivities] {
    
    let arr = dict.map { dic in
        SmallActivities(dict: dic)
    }
    return arr
}

struct Activities {
    
    var oldest: String
    var activities: [SmallActivities]
    
    init(dict: [String:Any]) {
        self.oldest = dict["oldest"] as! String
        self.activities = makeSmallActivities(dict: dict["activities"] as! [[String:Any]])
    }
}

struct SmallActivities {
    
    var message: String
    var amount: Double
    var userId: Int
    var timestamp: Date
    
    init(dict: [String:Any]) {
        self.message = dict["message"] as! String
        self.amount = dict["amount"] as! Double
        self.userId = dict["userId"] as! Int
        self.timestamp = DateFormatManager().dateFormatter(stringDate: (dict["timestamp"] as! String))
    }
}

class Users {

    var userId: Int?
    var displayName: String?
    var avatarUrl: String?
    
    init(dict: [String:Any]) {
        self.userId = dict["userId"] as! Int
        self.displayName = dict["displayName"] as! String
        self.avatarUrl = dict["avatarUrl"] as! String
    }
    
    init(userId: Int, displayName: String, avatarUrl: String) {
        self.userId = userId
        self.displayName = displayName
        self.avatarUrl = avatarUrl
    }
}


