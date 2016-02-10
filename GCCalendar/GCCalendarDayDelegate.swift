//
//  GCCalendarDayDelegate.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

protocol GCCalendarDayDelegate
{
    func dayView(dayView: GCCalendarDayView, didSelectDate date: NSDate)
}
