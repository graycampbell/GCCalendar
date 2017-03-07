//
//  GCDateFormatter.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCDateFormatter: DateFormatter {
    
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder) {
        
        return nil
    }
    
    internal init(dateFormat: String, calendar: Calendar) {
        
        super.init()
        
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}

// MARK: - String From Date

internal extension GCDateFormatter {
    
    internal class func string(fromDate date: Date, withFormat format: String, andCalendar calendar: Calendar) -> String {
        
        return GCDateFormatter(dateFormat: format, calendar: calendar).string(from: date)
    }
}
