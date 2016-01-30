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
    static var header: GCCalendarHeaderView!
    
    struct WeekdayLabel
    {
        static var font: UIFont = UIFont.systemFontOfSize(10)
        static var textColor: UIColor = UIColor(r: 146, g: 146, b: 146)
    }
    
    struct DayView
    {
        static let enabled: Bool = true
        
        static let enabledFont: UIFont = UIFont.systemFontOfSize(17)
        static let enabledTextColor: UIColor = UIColor.black(0.87)
        
        static let disabledFont: UIFont = UIFont.systemFontOfSize(17)
        static let disabledTextColor: UIColor = UIColor(r: 146, g: 146, b: 146)
        
        static let selectedFont: UIFont = UIFont.boldSystemFontOfSize(17)
        static let selectedTextColor: UIColor = UIColor.whiteColor()
        static let selectedBackgroundColor: UIColor = UIColor.black(0.87)
    }
    
    struct PastDayView
    {
        static var enabled: Bool = Calendar.DayView.enabled
        
        static var enabledFont: UIFont = Calendar.DayView.enabledFont
        static var enabledTextColor: UIColor = Calendar.DayView.enabledTextColor
        
        static var disabledFont: UIFont = Calendar.DayView.disabledFont
        static var disabledTextColor: UIColor = Calendar.DayView.disabledTextColor
        
        static var selectedFont: UIFont = Calendar.DayView.selectedFont
        static var selectedTextColor: UIColor = Calendar.DayView.selectedTextColor
        static var selectedBackgroundColor: UIColor = Calendar.DayView.selectedBackgroundColor
    }
    
    struct CurrentDayView
    {
        static var enabled: Bool = Calendar.DayView.enabled
        
        static var enabledFont: UIFont = UIFont.boldSystemFontOfSize(17)
        static var enabledTextColor: UIColor = Calendar.DayView.enabledTextColor
        
        static var disabledFont: UIFont = UIFont.boldSystemFontOfSize(17)
        static var disabledTextColor: UIColor = Calendar.DayView.disabledTextColor
        
        static var selectedFont: UIFont = Calendar.DayView.selectedFont
        static var selectedTextColor: UIColor = Calendar.DayView.selectedTextColor
        static var selectedBackgroundColor: UIColor = UIColor(r: 255, g: 58, b: 48)
    }
    
    struct FutureDayView
    {
        static var enabled: Bool = Calendar.DayView.enabled
        
        static var enabledFont: UIFont = Calendar.DayView.enabledFont
        static var enabledTextColor: UIColor = Calendar.DayView.enabledTextColor
        
        static var disabledFont: UIFont = Calendar.DayView.disabledFont
        static var disabledTextColor: UIColor = Calendar.DayView.disabledTextColor
        
        static var selectedFont: UIFont = Calendar.DayView.selectedFont
        static var selectedTextColor: UIColor = Calendar.DayView.selectedTextColor
        static var selectedBackgroundColor: UIColor = Calendar.DayView.selectedBackgroundColor
    }
}
