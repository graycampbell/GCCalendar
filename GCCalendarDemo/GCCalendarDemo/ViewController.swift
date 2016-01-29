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
        let width = NSLayoutConstraint(i: self.calendarView, a: .Width, i: self.view)
        let height = NSLayoutConstraint(i: self.calendarView, a: .Height, c: 350)
        let center = NSLayoutConstraint(i: self.calendarView, a: .CenterY, i: self.view)
        
        self.view.addConstraints([width, height, center])
    }
}
