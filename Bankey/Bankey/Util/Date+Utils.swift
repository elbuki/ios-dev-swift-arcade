//
//  Date+Utils.swift
//  Bankey
//
//  Created by Marco Carmona on 7/20/22.
//

import Foundation

extension Date {
    
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
