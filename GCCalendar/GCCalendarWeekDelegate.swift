//
//  GCCalendarWeekDelegate.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

protocol GCCalendarWeekDelegate
{
    func weekView(weekView: GCCalendarWeekView, didSelectDate date: NSDate)
}
