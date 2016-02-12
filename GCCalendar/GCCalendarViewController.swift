//
//  GCCalendarViewController.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public class GCCalendarViewController: UIViewController
{
    public var calendarView: GCCalendarView!
    
    internal var selectedDate: NSDate = NSDate()
    internal var selectedDayView: GCCalendarDayView?
    
    internal let currentCalendar = NSCalendar.currentCalendar()
}

// MARK: - Required Functions

public extension GCCalendarViewController
{
    public func didDisplayMonthWithStartDate(startDate: NSDate)
    {
        fatalError("Subclass of GCCalendarViewController must override didDisplayMonthWithStartDate")
    }
    
    public func didSelectDate(date: NSDate)
    {
        fatalError("Subclass of GCCalendarViewController must override didSelectDate")
    }
}

// MARK: - Optional Functions

public extension GCCalendarViewController
{
    public func shouldDisplayPreviousMonths() -> Bool
    {
        return true
    }
    
    // MARK: Weekday Label
    
    public func weekdayLabelFont() -> UIFont
    {
        return UIFont.systemFontOfSize(10)
    }
    
    public func weekdayLabelTextColor() -> UIColor
    {
        return UIColor(r: 146, g: 146, b: 146)
    }
    
    // MARK: Day View
    
    public func dayViewFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    public func dayViewTextColor() -> UIColor
    {
        return UIColor.black(0.87)
    }
    
    public func dayViewSelectedFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    public func dayViewSelectedTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    public func dayViewSelectedBackgroundColor() -> UIColor
    {
        return UIColor.black(0.87)
    }
    
    // MARK: Past Day View
    
    public func pastDaysEnabled() -> Bool
    {
        return true
    }
    
    public func pastDayViewFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    public func pastDayViewEnabledTextColor() -> UIColor
    {
        return UIColor.black(0.87)
    }
    
    public func pastDayViewDisabledTextColor() -> UIColor
    {
        return UIColor(r: 146, g: 146, b: 146)
    }
    
    public func pastDayViewSelectedFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    public func pastDayViewSelectedTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    public func pastDayViewSelectedBackgroundColor() -> UIColor
    {
        return UIColor.black(0.87)
    }
    
    // MARK: Current Day View
    
    public func currentDayViewFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    public func currentDayViewTextColor() -> UIColor
    {
        return UIColor(r: 255, g: 58, b: 48)
    }
    
    public func currentDayViewSelectedFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    public func currentDayViewSelectedTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    public func currentDayViewSelectedBackgroundColor() -> UIColor
    {
        return UIColor(r: 255, g: 58, b: 48)
    }
    
    // MARK: Future Day View
    
    public func futureDayViewFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    public func futureDayViewTextColor() -> UIColor
    {
        return UIColor.black(0.87)
    }
    
    public func futureDayViewSelectedFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    public func futureDayViewSelectedTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    public func futureDayViewSelectedBackgroundColor() -> UIColor
    {
        return UIColor.black(0.87)
    }
}
