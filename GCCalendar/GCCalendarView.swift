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
    
    private var viewController: GCCalendarViewController!
    private var headerView: GCCalendarHeaderView!
    private var monthViews: [GCCalendarMonthView] = []
    
    private var panGestureStartLocation: CGFloat!
    
    // MARK: - Initializers
    
    public convenience init(viewController: GCCalendarViewController?)
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addHeaderView()
        self.addMonthViews()
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.resetLayout()
    }
}

// MARK: - Header View

extension GCCalendarView
{
    // MARK: Creation
    
    private func addHeaderView()
    {
        self.headerView = GCCalendarHeaderView(viewController: self.viewController)
        
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
        let currentMonthComponents = self.viewController.currentCalendar.components([.Day, .Month, .Year], fromDate: self.viewController.selectedDate)
        currentMonthComponents.day = 1
        
        let currentMonthStartDate = self.viewController.currentCalendar.dateFromComponents(currentMonthComponents)!
        let previousMonthStartDate = self.previousMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        let nextMonthStartDate = self.nextMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        
        for startDate in [previousMonthStartDate, currentMonthStartDate, nextMonthStartDate]
        {
            let monthView = GCCalendarMonthView(viewController: self.viewController, startDate: startDate)
            monthView.addPanGestureRecognizer(self, action: "toggleCurrentMonth:")
            
            self.addSubview(monthView)
            self.monthViews.append(monthView)
            
            let top = NSLayoutConstraint(i: monthView, a: .Top, i: self.headerView, a: .Bottom)
            let bottom = NSLayoutConstraint(i: monthView, a: .Bottom, i: self)
            let width = NSLayoutConstraint(i: monthView, a: .Width, i: self)
            
            self.addConstraints([top, bottom, width])
        }
        
        self.resetLayout()
    }
    
    // MARK: Layout
    
    private func resetLayout()
    {
        self.previousMonthView.center.x = self.previousMonthViewCenter
        self.currentMonthView.center.x = self.currentMonthViewCenter
        self.nextMonthView.center.x = self.nextMonthViewCenter
    }
    
    private var previousMonthViewCenter: CGFloat {
        
        return -self.currentMonthViewCenter
    }
    
    private var currentMonthViewCenter: CGFloat {
        
        return self.bounds.size.width / 2
    }
    
    private var nextMonthViewCenter: CGFloat {
        
        return self.bounds.size.width + self.currentMonthViewCenter
    }
    
    // MARK: Previous Month, Current Month, & Next Month
    
    private var previousMonthView: GCCalendarMonthView {
        
        return self.monthViews[0]
    }
    
    private var currentMonthView: GCCalendarMonthView {
        
        return self.monthViews[1]
    }
    
    private var nextMonthView: GCCalendarMonthView {
        
        return self.monthViews[2]
    }
    
    // MARK: Start Dates
    
    private func previousMonthStartDate(currentMonthStartDate currentMonthStartDate: NSDate) -> NSDate
    {
        return self.viewController.currentCalendar.dateByAddingUnit(.Month, value: -1, toDate: currentMonthStartDate, options: .MatchStrictly)!
    }
    
    private func nextMonthStartDate(currentMonthStartDate currentMonthStartDate: NSDate) -> NSDate
    {
        return self.viewController.currentCalendar.nextDateAfterDate(currentMonthStartDate, matchingUnit: .Day, value: 1, options: .MatchStrictly)!
    }
    
    // MARK: - Toggle Current Month
    
    internal func toggleCurrentMonth(pan: UIPanGestureRecognizer)
    {
        if pan.state == .Began
        {
            self.panGestureStartLocation = pan.locationInView(self).x
        }
        else if pan.state == .Changed
        {
            let changeInX = pan.locationInView(self).x - self.panGestureStartLocation
            
            self.previousMonthView.center.x += changeInX
            self.currentMonthView.center.x += changeInX
            self.nextMonthView.center.x += changeInX
            
            self.panGestureStartLocation = pan.locationInView(self).x
        }
        else if pan.state == .Ended
        {
            if self.currentMonthView.center.x < 0
            {
                UIView.animateWithDuration(0.25, animations: self.showNextMonthView(), completion: self.nextMonthViewDidShow())
            }
            else if self.currentMonthView.center.x > self.currentMonthView.bounds.size.width
            {
                UIView.animateWithDuration(0.25, animations: self.showPreviousMonthView(), completion: self.previousMonthViewDidShow())
            }
            else
            {
                UIView.animateWithDuration(0.15) { self.resetLayout() }
            }
        }
    }
    
    // MARK: Show Next Month View
    
    private func showNextMonthView() -> () -> Void
    {
        return {
            
            self.currentMonthView.center.x = self.previousMonthViewCenter
            self.nextMonthView.center.x = self.currentMonthViewCenter
        }
    }
    
    private func nextMonthViewDidShow() -> ((Bool) -> Void)?
    {
        return { finished in
            
            let newStartDate = self.nextMonthStartDate(currentMonthStartDate: self.nextMonthView.startDate)
            
            self.previousMonthView.update(newStartDate: newStartDate)
            self.monthViews.append(self.previousMonthView)
            self.monthViews.removeFirst()
            
            self.resetLayout()
            
            self.currentMonthView.setSelectedDate()
        }
    }
    
    // MARK: Show Previous Month View
    
    private func showPreviousMonthView() -> () -> Void
    {
        return {
            
            self.previousMonthView.center.x = self.currentMonthViewCenter
            self.currentMonthView.center.x = self.nextMonthViewCenter
        }
    }
    
    private func previousMonthViewDidShow() -> ((Bool) -> Void)?
    {
        return { finished in
         
            let newStartDate = self.previousMonthStartDate(currentMonthStartDate: self.previousMonthView.startDate)
            
            self.nextMonthView.update(newStartDate: newStartDate)
            self.monthViews.insert(self.nextMonthView, atIndex: 0)
            self.monthViews.removeLast()
            
            self.resetLayout()
            
            self.currentMonthView.setSelectedDate()
        }
    }
}
