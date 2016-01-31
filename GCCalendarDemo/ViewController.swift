//
//  ViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit
import GCCalendar

class ViewController: UIViewController
{
    let calendarView = GCCalendarView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.addSubview(self.calendarView)
        self.addCalendarViewConstraints()
    }
    
    func addCalendarViewConstraints()
    {
        let bottom = NSLayoutConstraint(item: self.calendarView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: self.calendarView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: self.calendarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 340)
        
        self.view.addConstraints([bottom, width, height])
    }
}
