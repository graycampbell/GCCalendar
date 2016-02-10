//
//  ViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit
import GCCalendar

class ViewController: UIViewController, GCCalendarDelegate
{
    let dateLabel = UILabel()
    var calendarView: GCCalendarView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.addDateLabel()
        self.addCalendarView()
    }
    
    // MARK: - Date Label
    
    func addDateLabel()
    {
        self.dateLabel.textAlignment = .Center
        self.dateLabel.font = UIFont.boldSystemFontOfSize(14)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.dateLabel)
        self.addDateLabelConstraints()
    }
    
    func addDateLabelConstraints()
    {
        let top = NSLayoutConstraint(item: self.dateLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: self.dateLabel, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: self.dateLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 50)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - Calendar View
    
    func addCalendarView()
    {
        self.calendarView = GCCalendarView(delegate: self)
        
        self.view.addSubview(self.calendarView)
        self.addCalendarViewConstraints()
    }
    
    func addCalendarViewConstraints()
    {
        let top = NSLayoutConstraint(item: self.calendarView, attribute: .Top, relatedBy: .Equal, toItem: self.dateLabel, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: self.calendarView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: self.calendarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 325)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - GCCalendarDelegate
    
    func calenderView(calendarView: GCCalendarView, didSelectDate date: NSDate)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("EEEEdMMMMYYYY", options: 0, locale: NSLocale.currentLocale())
        
        self.dateLabel.text = dateFormatter.stringFromDate(date)
    }
    
    // MARK: - Status Bar
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
}
