//
//  GCCalendarMonthDelegate.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

protocol GCCalendarMonthDelegate
{
    func monthView(monthView: GCCalendarMonthView, didSelectDate date: NSDate)
}
