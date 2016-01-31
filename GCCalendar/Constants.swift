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
    
    static var view: GCCalendarView!
    static var selectedDate: NSDate = NSDate()
    static var selectedDayView: GCCalendarDayView?
    
    struct WeekdayLabel
    {
        static var font: UIFont = UIFont.systemFontOfSize(10)
        static var textColor: UIColor = UIColor(r: 146, g: 146, b: 146)
    }
    
    struct DayView
    {
        static let font: UIFont = UIFont.systemFontOfSize(17)
        
        static let textColor: UIColor = UIColor.black(0.87)
        
        static let selectedFont: UIFont = UIFont.boldSystemFontOfSize(17)
        static let selectedTextColor: UIColor = UIColor.whiteColor()
        static let selectedBackgroundColor: UIColor = UIColor.black(0.87)
    }
    
    struct PastDayView
    {
        static var enabled: Bool = true
        
        static var defaultFont: UIFont = Calendar.DayView.font
        
        static var enabledTextColor: UIColor = Calendar.DayView.textColor
        static var disabledTextColor: UIColor = UIColor(r: 146, g: 146, b: 146)
        
        static var selectedFont: UIFont = Calendar.DayView.selectedFont
        static var selectedTextColor: UIColor = Calendar.DayView.selectedTextColor
        static var selectedBackgroundColor: UIColor = Calendar.DayView.selectedBackgroundColor
    }
    
    struct CurrentDayView
    {
        static var font: UIFont = UIFont.boldSystemFontOfSize(17)
        static var textColor: UIColor = UIColor(r: 255, g: 58, b: 48)
        
        static var selectedFont: UIFont = Calendar.DayView.selectedFont
        static var selectedTextColor: UIColor = Calendar.DayView.selectedTextColor
        static var selectedBackgroundColor: UIColor = UIColor(r: 255, g: 58, b: 48)
    }
    
    struct FutureDayView
    {
        static var font: UIFont = Calendar.DayView.font
        static var textColor: UIColor = Calendar.DayView.textColor
        
        static var selectedFont: UIFont = Calendar.DayView.selectedFont
        static var selectedTextColor: UIColor = Calendar.DayView.selectedTextColor
        static var selectedBackgroundColor: UIColor = Calendar.DayView.selectedBackgroundColor
    }
}
