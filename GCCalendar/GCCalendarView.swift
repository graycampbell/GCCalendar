//
//  GCCalendarView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarView: UIView
{
    // MARK: - Properties
    
    var headerView: GCCalendarHeaderView!
    var monthViews: [GCCalendarMonthView] = []
    
    // MARK: - Initializers
    
    public convenience init()
    {
        self.init(frame: CGRectZero)
        
        Calendar.view = self
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addHeaderView()
        self.addMonthViews()
    }
}

// MARK: - Header View

extension GCCalendarView
{
    // MARK: Creation
    
    private func addHeaderView()
    {
        self.headerView = GCCalendarHeaderView()
        
        self.addSubview(self.headerView)
        self.addHeaderViewConstraints()
    }
    
    // MARK: Constraints
    
    private func addHeaderViewConstraints()
    {
        let top = NSLayoutConstraint(i: self.headerView, a: .Top, i: self)
        let width = NSLayoutConstraint(i: self.headerView, a: .Width, i: self)
        let height = NSLayoutConstraint(i: self.headerView, a: .Height, c: 15)
        
        self.addConstraints([top, width, height])
    }
}

// MARK: - Month Views

extension GCCalendarView
{
    // MARK: Creation
    
    private func addMonthViews()
    {
        let startDateComponents = Calendar.currentCalendar.components([.Day, .Month, .Year], fromDate: NSDate())
        startDateComponents.day = 1
        
        let startDate = Calendar.currentCalendar.dateFromComponents(startDateComponents)!
        
        for var i = 0; i < 3; i++
        {
            let monthView = GCCalendarMonthView()
            monthView.startDate = startDate
            
            monthView.addPanGestureRecognizer(self, action: "toggleCurrentMonth:")
            
            self.addSubview(monthView)
            self.monthViews.append(monthView)
            
            monthView.addWeekViews()
            
            monthView.topConstraint = NSLayoutConstraint(i: monthView, a: .Top, i: self.headerView, a: .Bottom)
            monthView.bottomConstraint = NSLayoutConstraint(i: monthView, a: .Bottom, i: self)
            monthView.widthConstraint = NSLayoutConstraint(i: monthView, a: .Width, i: self)
            
            self.addConstraints([monthView.topConstraint, monthView.bottomConstraint, monthView.widthConstraint])
        }
        
        self.updateConstraintsForMonthViews()
    }
    
    // MARK: Constraints
    
    private func updateConstraintsForMonthViews()
    {
        for monthView in self.monthViews
        {
            monthView.leftConstraint?.active = false
            monthView.rightConstraint?.active = false
        }
        
        self.updateConstraintsForPreviousMonthView()
    }
    
    private func updateConstraintsForPreviousMonthView()
    {
        self.previousMonthView.rightConstraint = NSLayoutConstraint(i: self.previousMonthView, a: .Right, i: self.currentMonthView, a: .Left)
        
        self.addConstraint(self.previousMonthView.rightConstraint)
    }
    
    private func updateConstraintsForNextMonthView()
    {
        self.nextMonthView.leftConstraint = NSLayoutConstraint(i: self.nextMonthView, a: .Left, i: self.currentMonthView, a: .Right)
        
        self.addConstraint(self.nextMonthView.leftConstraint)
    }
    
    // MARK: Properties
    
    private var previousMonthView: GCCalendarMonthView {
        
        return self.monthViews[0]
    }
    
    private var currentMonthView: GCCalendarMonthView {
        
        return self.monthViews[1]
    }
    
    private var nextMonthView: GCCalendarMonthView {
        
        return self.monthViews[2]
    }
}
