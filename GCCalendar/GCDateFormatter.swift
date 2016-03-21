//
//  GCDateFormatter.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//

import UIKit

internal class GCDateFormatter: NSDateFormatter
{
    internal convenience init(dateFormat: String, calendar: NSCalendar)
    {
        self.init()
        
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
    
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
