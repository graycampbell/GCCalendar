//
//  GCCalendarDelegate.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

@objc protocol GCCalendarDelegate
{
    func didSelectDate(date: NSDate)
    
    // MARK: - Weekday Label
    
    optional func weekdayLabelFont() -> UIFont
    optional func weekdayLabelTextColor() -> UIColor
    
    // MARK: - Day View
    
    func dayViewFont() -> UIFont
    func dayViewTextColor() -> UIColor
    
    func dayViewSelectedFont() -> UIFont
    func dayViewSelectedTextColor() -> UIColor
    func dayViewSelectedBackgroundColor() -> UIColor
    
    // MARK: - Past Day View
    
    func pastDaysEnabled() -> Bool
    
    func pastDayViewFont() -> UIFont
    func pastDayViewEnabledTextColor() -> UIColor
    func pastDayViewDisabledTextColor() -> UIColor
    
    func pastDayViewSelectedFont() -> UIFont
    func pastDayViewSelectedTextColor() -> UIColor
    func pastDayViewSelectedBackgroundColor() -> UIColor
    
    // MARK: - Current Day View
    
    func currentDayViewFont() -> UIFont
    func currentDayViewTextColor() -> UIColor
    
    func currentDayViewSelectedFont() -> UIFont
    func currentDayViewSelectedTextColor() -> UIColor
    func currentDayViewSelectedBackgroundColor() -> UIColor
    
    // MARK: - Future Day View
    
    func futureDayViewFont() -> UIFont
    func futureDayViewTextColor() -> UIColor
    
    func futureDayViewSelectedFont() -> UIFont
    func futureDayViewSelectedTextColor() -> UIColor
    func futureDayViewSelectedBackgroundColor() -> UIColor
}
