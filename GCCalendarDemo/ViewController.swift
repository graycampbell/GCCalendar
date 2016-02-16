//
//  ViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit
import GCCalendar

class ViewController: GCCalendarViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.addCalendarViewConstraints()
    }
    
    // MARK: - Calendar View
    
    private func addCalendarViewConstraints()
    {
        let top = NSLayoutConstraint(item: self.calendarView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 76)
        let width = NSLayoutConstraint(item: self.calendarView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self.calendarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 325)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - Override Functions
    
    override func didDisplayMonthWithStartDate(startDate: NSDate)
    {
        super.didDisplayMonthWithStartDate(startDate)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMMMYYYY", options: 0, locale: NSLocale.currentLocale())
        
        self.navigationItem.title = dateFormatter.stringFromDate(startDate)
    }
    
    override func didSelectDate(date: NSDate)
    {
        super.didSelectDate(date)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("EEEEdMMMMYYYY", options: 0, locale: NSLocale.currentLocale())
        
        let dateString = dateFormatter.stringFromDate(date)
        
        print(dateString)
    }
}
