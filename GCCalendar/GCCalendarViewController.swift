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
        
        self.calendarView = GCCalendarView(viewController: self)
        
        self.view.addSubview(self.calendarView)
    }
    
    internal func didSelectDayView(dayView: GCCalendarDayView)
    {
        self.selectedDayView = dayView
        
        self.didSelectDate(dayView.date!)
    }
}

// MARK: - Required Functions

public extension GCCalendarViewController
{
    /// Must call super.didSelectDate(date) before custom implementation
    public func didSelectDate(date: NSDate)
    {
        self.selectedDate = date
    }
    
    /// Must call super.didDisplayMonthWithStartDate(startDate) before custom implementation
    public func didDisplayMonthWithStartDate(startDate: NSDate)
    {
        self.displayedMonthStartDate = startDate
    }
}

// MARK: - Optional Functions

public extension GCCalendarViewController
{
    /// Default value is true
    public func shouldDisplayPreviousMonths() -> Bool
    {
        return true
    }
    
    // MARK: Weekday Label
    
    /// Default value is UIFont.systemFontOfSize(10)
    public func weekdayLabelFont() -> UIFont
    {
        return UIFont.systemFontOfSize(10)
    }
    
    /// Default value is UIColor.grayColor()
    public func weekdayLabelTextColor() -> UIColor
    {
        return UIColor.grayColor()
    }
    
    // MARK: Past Day View
    
    /// Default value is true
    public func pastDaysEnabled() -> Bool
    {
        return true
    }
    
    /// Default value is UIFont.systemFontOfSize(17)
    public func pastDayViewFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    public func pastDayViewEnabledTextColor() -> UIColor
    {
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    /// Default value is UIColor.grayColor()
    public func pastDayViewDisabledTextColor() -> UIColor
    {
        return UIColor.grayColor()
    }
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    public func pastDayViewSelectedFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    /// Default value is UIColor.whiteColor()
    public func pastDayViewSelectedTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    public func pastDayViewSelectedBackgroundColor() -> UIColor
    {
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    // MARK: Current Day View
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    public func currentDayViewFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    /// Default value is UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    public func currentDayViewTextColor() -> UIColor
    {
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    public func currentDayViewSelectedFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    /// Default value is UIColor.whiteColor()
    public func currentDayViewSelectedTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    /// Default value is UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    public func currentDayViewSelectedBackgroundColor() -> UIColor
    {
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    // MARK: Future Day View
    
    /// Default value is UIFont.systemFontOfSize(17)
    public func futureDayViewFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    public func futureDayViewTextColor() -> UIColor
    {
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    public func futureDayViewSelectedFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(17)
    }
    
    /// Default value is UIColor.whiteColor()
    public func futureDayViewSelectedTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    public func futureDayViewSelectedBackgroundColor() -> UIColor
    {
        return UIColor(white: 0.0, alpha: 0.87)
    }
}
