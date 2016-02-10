//
//  Constants.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

struct Calendar
{
    static let currentCalendar = NSCalendar.currentCalendar()
    
    static var selectedDate: NSDate = NSDate()
    static var selectedDayView: GCCalendarDayView?
    
    struct WeekdayLabel
    {
        static var font: UIFont = UIFont.systemFontOfSize(10)
        static var textColor: UIColor = UIColor(r: 146, g: 146, b: 146)
    }
}
