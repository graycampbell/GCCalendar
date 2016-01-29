//
//  ViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

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
        let heightConstant = min(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        let bottom = NSLayoutConstraint(i: self.calendarView, a: .Bottom, i: self.view)
        let width = NSLayoutConstraint(i: self.calendarView, a: .Width, i: self.view)
        let height = NSLayoutConstraint(i: self.calendarView, a: .Height, c: heightConstant)
        
        self.view.addConstraints([bottom, width, height])
    }
}
