//
//  GCCalendarViewDelegate.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

@objc public protocol GCCalendarViewDelegate
{
    func calendarView(calendarView: GCCalendarView, didSelectDate date: NSDate)
    
    // MARK: - Weekday Label
    
    optional func weekdayLabelFont() -> UIFont
    optional func weekdayLabelTextColor() -> UIColor
    
    // MARK: - Day View
    
    optional func dayViewFont() -> UIFont
    optional func dayViewTextColor() -> UIColor
    
    optional func dayViewSelectedFont() -> UIFont
    optional func dayViewSelectedTextColor() -> UIColor
    optional func dayViewSelectedBackgroundColor() -> UIColor
    
    // MARK: - Past Day View
    
    optional func pastDaysEnabled() -> Bool
    
    optional func pastDayViewFont() -> UIFont
    optional func pastDayViewEnabledTextColor() -> UIColor
    optional func pastDayViewDisabledTextColor() -> UIColor
    
    optional func pastDayViewSelectedFont() -> UIFont
    optional func pastDayViewSelectedTextColor() -> UIColor
    optional func pastDayViewSelectedBackgroundColor() -> UIColor
    
    // MARK: - Current Day View
    
    optional func currentDayViewFont() -> UIFont
    optional func currentDayViewTextColor() -> UIColor
    
    optional func currentDayViewSelectedFont() -> UIFont
    optional func currentDayViewSelectedTextColor() -> UIColor
    optional func currentDayViewSelectedBackgroundColor() -> UIColor
    
    // MARK: - Future Day View
    
    optional func futureDayViewFont() -> UIFont
    optional func futureDayViewTextColor() -> UIColor
    
    optional func futureDayViewSelectedFont() -> UIFont
    optional func futureDayViewSelectedTextColor() -> UIColor
    optional func futureDayViewSelectedBackgroundColor() -> UIColor
}
