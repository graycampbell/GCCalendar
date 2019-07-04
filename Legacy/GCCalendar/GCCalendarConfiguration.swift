//
//  GCCalendarConfiguration.swift
//  GCCalendar
//
//  Created by Gray Campbell on 3/6/17.
//

import UIKit

internal struct GCCalendarConfiguration {
    
    // MARK: Calendar
    
    internal var calendar: Calendar!
    
    // MARK: Weekday Labels
    
    internal var weekdayLabelFont: UIFont!
    internal var weekdayLabelTextColor: UIColor!
    
    // MARK: Past Dates
    
    internal var pastDatesEnabled: Bool = true
    
    internal var pastDateFont: UIFont!
    internal var pastDateEnabledTextColor: UIColor!
    internal var pastDateDisabledTextColor: UIColor!
    internal var pastDateSelectedFont: UIFont!
    internal var pastDateSelectedTextColor: UIColor!
    internal var pastDateSelectedBackgroundColor: UIColor!
    
    // MARK: Current Dates
    
    internal var currentDateFont: UIFont!
    internal var currentDateTextColor: UIColor!
    internal var currentDateSelectedFont: UIFont!
    internal var currentDateSelectedTextColor: UIColor!
    internal var currentDateSelectedBackgroundColor: UIColor!
    
    // MARK: Future Dates
    
    internal var futureDateFont: UIFont!
    internal var futureDateTextColor: UIColor!
    internal var futureDateSelectedFont: UIFont!
    internal var futureDateSelectedTextColor: UIColor!
    internal var futureDateSelectedBackgroundColor: UIColor!
    
    // MARK: Date Selection
    
    internal var selectedDate: (() -> Date)!
    internal var dayViewSelected: ((GCCalendarDayView) -> Void)!
}
