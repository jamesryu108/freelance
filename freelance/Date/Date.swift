//
//  Date.swift
//  Date
//
//  Created by James Ryu on 2021-09-05.
//

import Foundation
import UIKit

extension Date {
    
    func formatYourDate(format: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "UTC")
        let string = formatter.string(from: self)
        return string
    }
    
    func formatStringDateToDate(format: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "UTC")
        let string = formatter.string(from: self)

        let formatter2 = DateFormatter()
        formatter2.dateFormat = format
        formatter2.timeZone = TimeZone(identifier: "UTC")
        return formatter2.date(from: string)!
    }
    
    func subtract2Weeks() -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: -14, to: self)!
    }
    
    func add2Weeks() -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: -14, to: self)!
    }
    
    func subtractday() -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: -1, to: self)!
    }
    
    func addSecond(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .second, value: n, to: self)!
    }
    
    func subtractSecond(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .second, value: -n, to: self)!
    }
}
