//
//  String.swift
//  String
//
//  Created by James Ryu on 2021-09-04.
//

import Foundation
import UIKit

// Build your own String Extension for grabbing a character at a specific position

extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
    
    mutating func replacing(_ originalString:String, with newString:String) {
           self = self.replacingOccurrences(of: originalString, with: newString)
       }
}

extension String {
    
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        df.timeZone = .current
        return df.date(from: self)
    }
}
