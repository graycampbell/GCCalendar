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
    
    public var selectedDate: NSDate = NSDate()
    public var displayedMonthStartDate: NSDate!
    
    internal var selectedDayView: GCCalendarDayView?
    
    internal let currentCalendar = NSCalendar.currentCalendar()
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
    }
}

// MARK: - Required Functions

public extension GCCalendarViewController
{
    internal func didSelectDayView(dayView: GCCalendarDayView)
    {
        self.selectedDayView = dayView
        
        self.didSelectDate(dayView.date!)
    }
    
    public func didSelectDate(date: NSDate)
    {
        self.selectedDate = date
    }
    
    public func didDisplayMonthWithStartDate(startDate: NSDate)
    {
        self.displayedMonthStartDate = startDate
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
        return UIColor(red: 146 / 255, green: 146 / 255, blue: 146 / 255, alpha: 1.0)
    }
    
    // MARK: Day View
    
    public func dayViewFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    public func dayViewTextColor() -> UIColor
    {
        return UIColor(white: 0.0, alpha: 0.87)
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
        return UIColor(white: 0.0, alpha: 0.87)
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
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    public func pastDayViewDisabledTextColor() -> UIColor
    {
        return UIColor(red: 146 / 255, green: 146 / 255, blue: 146 / 255, alpha: 1.0)
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
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    // MARK: Current Day View
    
    public func currentDayViewFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    public func currentDayViewTextColor() -> UIColor
    {
        return UIColor(red: 255 / 255, green: 58 / 255, blue: 48 / 255, alpha: 1.0)
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
        return UIColor(red: 255 / 255, green: 58 / 255, blue: 48 / 255, alpha: 1.0)
    }
    
    // MARK: Future Day View
    
    public func futureDayViewFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    public func futureDayViewTextColor() -> UIColor
    {
        return UIColor(white: 0.0, alpha: 0.87)
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
        return UIColor(white: 0.0, alpha: 0.87)
    }
}
