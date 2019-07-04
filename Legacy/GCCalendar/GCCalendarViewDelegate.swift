//
//  GCCalendarViewDelegate.swift
//  GCCalendar
//
//  Created by Gray Campbell on 3/4/17.
//

import UIKit

// MARK: Protocol

/// The delegate of a GCCalendarView object must adopt the GCCalendarViewDelegate protocol. The protocol's optional methods allow the delegate to handle date selection and customize the calendar view's appearance.

public protocol GCCalendarViewDelegate: class {
    
    // MARK: Date Selection
    
    /// Tells the delegate that the calendar view selected a new date in the specified calendar.
    ///
    /// - Parameter calendarView: The calendar view.
    /// - Parameter date: The selected date.
    /// - Parameter calendar: The calendar used to configure the calendar view.
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar)
    
    // MARK: Calendar
    
    /// Asks the delegate to provide the calendar for the calendar view.
    ///
    /// ---
    ///
    /// **Default Value**
    ///
    /// `Calendar.current`
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: The calendar for the calendar view.
    
    func calendar(calendarView: GCCalendarView) -> Calendar
    
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
    
    func weekdayLabelFont(calendarView: GCCalendarView) -> UIFont
    
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
    
    func weekdayLabelTextColor(calendarView: GCCalendarView) -> UIColor
    
    // MARK: Past Dates
    
    /// Asks the delegate if the calendar view should enable past dates.
    ///
    /// ---
    ///
    /// The default value is true. If returning false, the calendar view will make past dates unselectable and will only display past dates for the current week or month, depending on the calendar display mode.
    ///
    /// - Parameter calendarView: The calendar view requesting this information.
    /// - Returns: A Boolean value inidicating whether or not the calendar view should enable past dates.
    
    func pastDatesEnabled(calendarView: GCCalendarView) -> Bool
    
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
    
    func pastDateFont(calendarView: GCCalendarView) -> UIFont
    
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
    
    func pastDateEnabledTextColor(calendarView: GCCalendarView) -> UIColor
    
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
    
    func pastDateDisabledTextColor(calendarView: GCCalendarView) -> UIColor
    
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
    
    func pastDateSelectedFont(calendarView: GCCalendarView) -> UIFont
    
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
    
    func pastDateSelectedTextColor(calendarView: GCCalendarView) -> UIColor
    
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
    
    func pastDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor
    
    // MARK: Current Date
    
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
    
    func currentDateFont(calendarView: GCCalendarView) -> UIFont
    
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
    
    func currentDateTextColor(calendarView: GCCalendarView) -> UIColor
    
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
    
    func currentDateSelectedFont(calendarView: GCCalendarView) -> UIFont
    
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
    
    func currentDateSelectedTextColor(calendarView: GCCalendarView) -> UIColor
    
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
    
    func currentDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor
    
    // MARK: Future Dates
    
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
    
    func futureDateFont(calendarView: GCCalendarView) -> UIFont
    
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
    
    func futureDateTextColor(calendarView: GCCalendarView) -> UIColor
    
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
    
    func futureDateSelectedFont(calendarView: GCCalendarView) -> UIFont
    
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
    
    func futureDateSelectedTextColor(calendarView: GCCalendarView) -> UIColor
    
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
    
    func futureDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor
}

// MARK: - Default Implementations

public extension GCCalendarViewDelegate {
    
    // MARK: Calendar
    
    func calendar(calendarView: GCCalendarView) -> Calendar {
        
        return Calendar.current
    }
    
    // MARK: Weekday Labels
    
    func weekdayLabelFont(calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.systemFont(ofSize: 10)
    }
    
    func weekdayLabelTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.gray
    }
    
    // MARK: Past Dates
    
    func pastDatesEnabled(calendarView: GCCalendarView) -> Bool {
        
        return true
    }
    
    func pastDateFont(calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.systemFont(ofSize: 17)
    }
    
    func pastDateEnabledTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    func pastDateDisabledTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.gray
    }
    
    func pastDateSelectedFont(calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    func pastDateSelectedTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.white
    }
    
    func pastDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    // MARK: Current Date
    
    func currentDateFont(calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    func currentDateTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    func currentDateSelectedFont(calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    func currentDateSelectedTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.white
    }
    
    func currentDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    // MARK: Future Dates
    
    func futureDateFont(calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.systemFont(ofSize: 17)
    }
    
    func futureDateTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    func futureDateSelectedFont(calendarView: GCCalendarView) -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    func futureDateSelectedTextColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor.white
    }
    
    func futureDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
}
