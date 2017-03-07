//
//  GCCalendarConfiguration.swift
//  GCCalendar
//
//  Created by MacBook Pro on 3/6/17.
//  Copyright © 2017 Gray Campbell. All rights reserved.
//

import UIKit

struct GCCalendarConfiguration {
    
    var calendar = Calendar.current
    var appearance = GCCalendarAppearance()
    
    var selectedDate: (() -> Date)!
    var dayViewSelected: ((GCCalendarDayView) -> Void)?
}
