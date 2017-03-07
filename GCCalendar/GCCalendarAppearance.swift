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
    
    var pastDatesEnabled: Bool = true
    
    var pastDateFont: UIFont!
    var pastDateEnabledTextColor: UIColor!
    var pastDateDisabledTextColor: UIColor!
    var pastDateSelectedFont: UIFont!
    var pastDateSelectedTextColor: UIColor!
    var pastDateSelectedBackgroundColor: UIColor!
    
    // MARK: Current Day Views
    
    var currentDateFont: UIFont!
    var currentDateTextColor: UIColor!
    var currentDateSelectedFont: UIFont!
    var currentDateSelectedTextColor: UIColor!
    var currentDateSelectedBackgroundColor: UIColor!
    
    // MARK: Future Day Views
    
    var futureDateFont: UIFont!
    var futureDateTextColor: UIColor!
    var futureDateSelectedFont: UIFont!
    var futureDateSelectedTextColor: UIColor!
    var futureDateSelectedBackgroundColor: UIColor!
}
