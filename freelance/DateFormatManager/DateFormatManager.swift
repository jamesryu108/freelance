//
//  DateFormatManager.swift
//  DateFormatManager
//
//  Created by James Ryu on 2021-09-01.
//

import Foundation

class DateFormatManager {
    
    init() {
        
    }
    
    /// Converts date in String in certain format to Date object.
    func dateFormatter(stringDate: String) -> Date {
        
        // 2021-08-03T00:00:00+00:00
        
        let df = DateFormatter()
        
            df.calendar = .current
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        
        return df.date(from: stringDate)!
    }
}
