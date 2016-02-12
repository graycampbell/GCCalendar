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
    private let monthLabel = UILabel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.addMonthLabel()
        self.addCalendarView()
    }
    
    // MARK: - Month Label
    
    private func addMonthLabel()
    {
        self.monthLabel.textAlignment = .Center
        self.monthLabel.font = UIFont.boldSystemFontOfSize(14)
        self.monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.monthLabel)
        self.addMonthLabelConstraints()
    }
    
    private func addMonthLabelConstraints()
    {
        let top = NSLayoutConstraint(item: self.monthLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: self.monthLabel, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: self.monthLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 50)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - Calendar View
    
    private func addCalendarView()
    {
        self.calendarView = GCCalendarView(viewController: self)
        
        self.view.addSubview(self.calendarView)
        self.addCalendarViewConstraints()
    }
    
    private func addCalendarViewConstraints()
    {
        let top = NSLayoutConstraint(item: self.calendarView, attribute: .Top, relatedBy: .Equal, toItem: self.monthLabel, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: self.calendarView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: self.calendarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 325)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - Override Functions
    
    override func didDisplayMonthWithStartDate(startDate: NSDate)
    {
        super.didDisplayMonthWithStartDate(startDate)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMMMYYYY", options: 0, locale: NSLocale.currentLocale())
        
        self.monthLabel.text = dateFormatter.stringFromDate(startDate)
    }
    
    override func didSelectDate(date: NSDate)
    {
        super.didSelectDate(date)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("EEEEdMMMMYYYY", options: 0, locale: NSLocale.currentLocale())
        
        let dateString = dateFormatter.stringFromDate(date)
        
        print(dateString)
    }
    
    // MARK: - Status Bar
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
}
