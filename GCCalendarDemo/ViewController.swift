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
        
        let tintColor = UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        
        self.navigationController!.toolbar.tintColor = tintColor
        self.navigationController!.navigationBar.tintColor = tintColor
        
        self.navigationController!.navigationBar.shadowImage = UIImage(named: "NavigationBarShadowImage")
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "NavigationBarBackgroundImage"), forBarMetrics: .Default)
        
        self.addToolbar()
        self.addCalendarViewConstraints()
    }
    
    // MARK: - Toolbar
    
    private func addToolbar()
    {
        self.navigationController!.toolbarHidden = false
        
        let today = UIBarButtonItem(title: "Today", style: .Plain, target: self.calendarView, action: #selector(self.calendarView.today))
        
        self.toolbarItems = [today]
        
        let shadowImage = UIImage(named: "ToolbarShadowImage")
        let backgroundImage = UIImage(named: "NavigationBarBackgroundImage")
        
        self.navigationController!.toolbar.setShadowImage(shadowImage, forToolbarPosition: .Bottom)
        self.navigationController!.toolbar.setBackgroundImage(backgroundImage, forToolbarPosition: .Bottom, barMetrics: .Default)
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
