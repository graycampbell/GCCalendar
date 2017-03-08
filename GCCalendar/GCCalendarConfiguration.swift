//
//  GCCalendarConfiguration.swift
//  GCCalendar
//
//  Created by Gray Campbell on 3/6/17.
//

import UIKit

internal struct GCCalendarConfiguration {
    
    internal var calendar: Calendar!
    internal var appearance = GCCalendarAppearance()
    
    internal var selectedDate: (() -> Date)!
    internal var selectedDayView: (() -> GCCalendarDayView?)!
    internal var dayViewSelected: ((GCCalendarDayView) -> Void)!
}
