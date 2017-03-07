//
//  GCCalendarViewDelegate.swift
//  GCCalendar
//
//  Created by MacBook Pro on 3/4/17.
//  Copyright © 2017 Gray Campbell. All rights reserved.
//

import UIKit

// MARK: Protocol

/// The delegate of a GCCalendarView object must adopt the GCCalendarViewDelegate protocol. The protocol's optional methods allow the delegate to handle date selection and customize the calendar's appearance.

public protocol GCCalendarViewDelegate: class {
    
    // MARK: Date Selection
    
    /// Tells the delegate that a new date was selected for the specified calendar view.
    ///
    /// - Parameter calendarView: The calendar view.
    /// - Parameter date: The selected date.
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date)
    
    // MARK: Weekday Labels
    
    /// Asks the delegate to provide the font for the calendar view's weekday labels.
    ///
    /// The default value is UIFont.systemFont(ofSize: 10).
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The font for the weekday labels.
    
    func weekdayLabelFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the text color for the calendar view's weekday labels.
    ///
    /// The default value is UIColor.gray.
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The text color for the weekday labels.
    
    func weekdayLabelTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    // MARK: Past Day Views
    
    /// Asks the delegate if the calendar view should enable days prior to the current date.
    ///
    /// The default value is true. If returning false, the calendar view will make past days unselectable and will only display past days for the current month (or week, depending on the calendar mode).
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: A boolean value inidicating whether or not the calendar view should enable days prior to the current date.
    
    func pastDaysEnabled(forCalendarView calendarView: GCCalendarView) -> Bool
    
    /// Asks the delegate to provide the font for the calendar view's **unselected** past day views.
    ///
    /// The default value is UIFont.systemFont(ofSize: 17).
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The font for unselected past day views.
    
    func pastDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the text color for the calendar view's **enabled** past day views.
    ///
    /// The default value is UIColor(white: 0.0, alpha: 0.87).
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The text color for enabled past day views.
    
    func pastDayViewEnabledTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the text color for the calendar view's **disabled** past day views.
    ///
    /// The default value is UIColor.gray.
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The text color for disabled past day views.
    
    func pastDayViewDisabledTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the font for the calendar view's **selected** past day views.
    ///
    /// The default value is UIFont.boldSystemFont(ofSize: 17).
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The font for selected past day views.
    
    func pastDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the text color for the calendar view's **selected** past day views.
    ///
    /// The default value is UIColor.white.
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The text color for selected past day views.
    
    func pastDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the background color for the calendar view's **selected** past day views.
    ///
    /// The default value is UIColor(white: 0.0, alpha: 0.87).
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The background color for selected past day views.
    
    func pastDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    // MARK: Current Day Views
    
    /// Asks the delegate to provide the font for the day view representing the current day.
    ///
    /// The default value is UIFont.boldSystemFontOfSize(17)
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The specified font.
    
    func currentDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Default value is UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    func currentDayViewTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    func currentDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Default value is UIColor.whiteColor()
    func currentDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Default value is UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    func currentDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    // MARK: Future Day Views
    
    /// Default value is UIFont.systemFontOfSize(17)
    func futureDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    func futureDayViewTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    func futureDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Default value is UIColor.whiteColor()
    func futureDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    func futureDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor
}

// MARK: - Default Implementations

public extension GCCalendarViewDelegate {
    
    public func calendar(forCalendarView calendarView: GCCalendarView) -> Calendar {
        
        return Calendar.current
    }
    
    // MARK: Weekday Labels
    
    public func weekdayLabelFont(forCalendarView calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.systemFont(ofSize: 10)
    }
    
    public func weekdayLabelTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.gray
    }
    
    // MARK: Past Day Views
    
    public func pastDaysEnabled(forCalendarView calendarView: GCCalendarView) -> Bool {
        
        return true
    }
    
    public func pastDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.systemFont(ofSize: 17)
    }
    
    public func pastDayViewEnabledTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    public func pastDayViewDisabledTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.gray
    }
    
    public func pastDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    public func pastDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.white
    }
    
    public func pastDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    // MARK: Current Day Views
    
    public func currentDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    public func currentDayViewTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    public func currentDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    public func currentDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.white
    }
    
    public func currentDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    // MARK: Future Day Views
    
    public func futureDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.systemFont(ofSize: 17)
    }
    
    public func futureDayViewTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    public func futureDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    public func futureDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.white
    }
    
    public func futureDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
}
