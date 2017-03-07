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
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIFont.systemFont(ofSize: 10)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The font for the weekday labels.
    
    func weekdayLabelFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the text color for the calendar view's weekday labels.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor.gray`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The text color for the weekday labels.
    
    func weekdayLabelTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    // MARK: Past Day Views
    
    /// Asks the delegate if the calendar view should enable past dates.
    ///
    /// ---
    ///
    /// The default value is true. If returning false, the calendar view will make past dates unselectable and will only display past dates for the current week or month, depending on the calendar display mode.
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: A boolean value inidicating whether or not the calendar view should enable past dates.
    
    func pastDaysEnabled(forCalendarView calendarView: GCCalendarView) -> Bool
    
    /// Asks the delegate to provide the **unselected** font for past dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIFont.systemFont(ofSize: 17)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The unselected font for past dates.
    
    func pastDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the **enabled** text color for past dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor(white: 0.0, alpha: 0.87)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The enabled text color for past dates.
    
    func pastDayViewEnabledTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the **disabled** text color for past dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor.gray`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The disabled text color for past dates.
    
    func pastDayViewDisabledTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the **selected** font for past dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIFont.boldSystemFont(ofSize: 17)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected font for past dates.
    
    func pastDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the **selected** text color for past dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor.white`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected text color for past dates.
    
    func pastDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the **selected** background color for past dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor(white: 0.0, alpha: 0.87)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected background color for past dates.
    
    func pastDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    // MARK: Current Day Views
    
    /// Asks the delegate to provide the **unselected** font for the current date.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIFont.boldSystemFont(ofSize: 17)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The unselected font for the current date.
    
    func currentDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the **unselected** text color for the current date.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The unselected text color for the current date.
    
    func currentDayViewTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the **selected** font for the current date.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIFont.boldSystemFont(ofSize: 17)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected font for the current date.
    
    func currentDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the **selected** text color for the current date.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor.white`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected text color for the current date.
    
    func currentDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the **selected** background color for the current date.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected background color for the current date.
    
    func currentDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    // MARK: Future Day Views
    
    /// Asks the delegate to provide the **unselected** font for future dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIFont.systemFont(ofSize: 17)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The unselected font for future dates.
    
    func futureDayViewFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the **unselected** text color for future dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor(white: 0.0, alpha: 0.87)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The unselected text color for future dates.
    
    func futureDayViewTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the **selected** font for future dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIFont.boldSystemFont(ofSize: 17)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected font for future dates.
    
    func futureDayViewSelectedFont(forCalendarView calendarView: GCCalendarView) -> UIFont
    
    /// Asks the delegate to provide the **selected** text color for future dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor.white`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected text color for future dates.
    
    func futureDayViewSelectedTextColor(forCalendarView calendarView: GCCalendarView) -> UIColor
    
    /// Asks the delegate to provide the **selected** background color for future dates.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `UIColor(white: 0.0, alpha: 0.87)`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The selected background color for future dates.
    
    func futureDayViewSelectedBackgroundColor(forCalendarView calendarView: GCCalendarView) -> UIColor
}

// MARK: - Default Implementations

public extension GCCalendarViewDelegate {
    
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
