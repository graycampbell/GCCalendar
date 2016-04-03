//
//  GCDateFormatter.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCDateFormatter: NSDateFormatter
{
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    internal init(dateFormat: String, calendar: NSCalendar)
    {
        super.init()
        
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}

// MARK: - String From Date

extension GCDateFormatter
{
    internal class func stringFromDate(date: NSDate, withFormat format: String, andCalendar calendar: NSCalendar) -> String
    {
        var dateFormatter: NSDateFormatter!
        var onceToken: dispatch_once_t = 0
        
        dispatch_once(&onceToken) {
            
            dateFormatter = GCDateFormatter(dateFormat: "d", calendar: calendar)
        }
        
        return dateFormatter.stringFromDate(date)
    }
}
