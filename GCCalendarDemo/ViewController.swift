//
//  ViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit
import GCCalendar

class ViewController: GCCalendarViewController
{
    // MARK: - View Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.shadowImage = UIImage(named: "NavigationBarShadowImage")
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "NavigationBar"), forBarMetrics: .Default)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Today", style: .Plain, target: self.calendarView, action: "today")
        
        self.addCalendarViewConstraints()
    }
    
    // MARK: - Calendar View
    
    private func addCalendarViewConstraints()
    {
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: self.calendarView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 12)
        let width = NSLayoutConstraint(item: self.calendarView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self.calendarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 325)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - Override Functions
    
    override func shouldAutomaticallyChangeModeOnOrientationChange() -> Bool
    {
        return true
    }
    
    override func didSelectDate(date: NSDate)
    {
        super.didSelectDate(date)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMMMYYYY", options: 0, locale: NSLocale.currentLocale())
        
        self.navigationItem.title = dateFormatter.stringFromDate(date)
    }
}
