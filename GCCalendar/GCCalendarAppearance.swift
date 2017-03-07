//
//  GCCalendarAppearance.swift
//  GCCalendar
//
//  Created by MacBook Pro on 3/6/17.
//  Copyright © 2017 Gray Campbell. All rights reserved.
//

import UIKit

struct GCCalendarAppearance {
    
    // MARK: Weekday Labels
    
    var weekdayLabelFont: UIFont!
    var weekdayLabelTextColor: UIColor!
    
    // MARK: Past Day Views
    
    var pastDaysEnabled: Bool = true
    
    var pastDayViewFont: UIFont!
    var pastDayViewEnabledTextColor: UIColor!
    var pastDayViewDisabledTextColor: UIColor!
    var pastDayViewSelectedFont: UIFont!
    var pastDayViewSelectedTextColor: UIColor!
    var pastDayViewSelectedBackgroundColor: UIColor!
    
    // MARK: Current Day Views
    
    var currentDayViewFont: UIFont!
    var currentDayViewTextColor: UIColor!
    var currentDayViewSelectedFont: UIFont!
    var currentDayViewSelectedTextColor: UIColor!
    var currentDayViewSelectedBackgroundColor: UIColor!
    
    // MARK: Future Day Views
    
    var futureDayViewFont: UIFont!
    var futureDayViewTextColor: UIColor!
    var futureDayViewSelectedFont: UIFont!
    var futureDayViewSelectedTextColor: UIColor!
    var futureDayViewSelectedBackgroundColor: UIColor!
}
