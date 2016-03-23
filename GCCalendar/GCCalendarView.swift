//
//  GCCalendarView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

public final class GCCalendarView: UIView
{
    // MARK: - Properties
    
    private weak var viewController: GCCalendarViewController!
    
    private var mode: GCCalendarMode!
    private var headerView: GCCalendarHeaderView!
    private var monthViews: [GCCalendarMonthView] = []
    private var weekViews: [GCCalendarWeekView] = []
    
    private var panGestureStartLocation: CGFloat!
    
    public enum GCCalendarMode
    {
        case Month, Week
    }
    
    // MARK: - Initializers
    
    public convenience init(viewController: GCCalendarViewController?, mode: GCCalendarMode)
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        self.mode = mode
        
        self.addHeaderView()
        
        (self.mode == .Month) ? self.addMonthViews() : self.addWeekViews()
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.resetLayout()
    }
    
    private func resetLayout()
    {
        self.previousView.center.x = -self.bounds.size.width * 0.5
        self.currentView.center.x = self.bounds.size.width * 0.5
        self.nextView.center.x = self.bounds.size.width * 1.5
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
        let top = NSLayoutConstraint(item: self.headerView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.headerView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self.headerView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 15)
        
        self.addConstraints([top, width, height])
    }
}

// MARK: - Month & Week Views

extension GCCalendarView
{
    // MARK: Properties
    
    private var previousView: UIView {
        
        return (self.mode == .Month) ? self.previousMonthView : self.previousWeekView
    }
    
    private var currentView: UIView {
        
        return (self.mode == .Month) ? self.currentMonthView : self.currentWeekView
    }
    
    private var nextView: UIView {
        
        return (self.mode == .Month) ? self.nextMonthView : self.nextWeekView
    }
    
    // MARK: Change Mode
    
    public func changeModeTo(newMode: GCCalendarMode)
    {
        if newMode != self.mode
        {
            self.mode = newMode
            
            if self.mode == .Month
            {
                self.removeWeekViews()
                self.addMonthViews()
            }
            else
            {
                self.removeMonthViews()
                self.addWeekViews()
            }
        }
    }
    
    // MARK: Today
    
    public func today()
    {
        (self.mode == .Month) ? self.findTodayInMonthViews() : self.findTodayInWeekViews()
    }
    
    private func findTodayInMonthViews()
    {
        for monthView in self.monthViews
        {
            if self.viewController.calendar.isDate(monthView.startDate, equalToDate: NSDate(), toUnitGranularity: .Month)
            {
                monthView.setSelectedDate()
                
                return
            }
        }
    }
    
    private func findTodayInWeekViews()
    {
        for weekView in self.weekViews
        {
            for date in weekView.dates
            {
                if date != nil && self.viewController.calendar.isDateInToday(date!)
                {
                    let todayComponents = self.viewController.calendar.components([.Weekday, .WeekOfYear], fromDate: NSDate())
                    
                    weekView.setSelectedDate(weekday: todayComponents.weekday)
                    
                    return
                }
            }
        }
    }
    
    // MARK: Toggle Current View
    
    internal func toggleCurrentView(pan: UIPanGestureRecognizer)
    {
        if pan.state == .Began
        {
            self.panGestureStartLocation = pan.locationInView(self).x
        }
        else if pan.state == .Changed
        {
            let changeInX = pan.locationInView(self).x - self.panGestureStartLocation
            
            if !(self.previousView.hidden && self.currentView.center.x + changeInX > self.bounds.size.width * 0.5)
            {
                self.previousView.center.x += changeInX
                self.currentView.center.x += changeInX
                self.nextView.center.x += changeInX
            }
            
            self.panGestureStartLocation = pan.locationInView(self).x
        }
        else if pan.state == .Ended
        {
            if self.currentView.center.x < (self.bounds.size.width * 0.5) - 25
            {
                UIView.animateWithDuration(0.25, animations: self.showNextView(), completion: self.nextViewDidShow())
            }
            else if self.currentView.center.x > (self.bounds.size.width * 0.5) + 25
            {
                UIView.animateWithDuration(0.25, animations: self.showPreviousView(), completion: self.previousViewDidShow())
            }
            else
            {
                UIView.animateWithDuration(0.15) { self.resetLayout() }
            }
        }
    }
    
    // MARK: Show Previous View
    
    private func showPreviousView() -> () -> Void
    {
        return {
            
            self.previousView.center.x = self.bounds.size.width * 0.5
            self.currentView.center.x = self.bounds.size.width * 1.5
        }
    }
    
    private func previousViewDidShow() -> ((Bool) -> Void)?
    {
        return (self.mode == .Month) ? self.previousMonthViewDidShow() : self.previousWeekViewDidShow()
    }
    
    private func showNextView() -> () -> Void
    {
        return {
            
            self.currentView.center.x = -self.bounds.size.width * 0.5
            self.nextView.center.x = self.bounds.size.width * 0.5
        }
    }
    
    private func nextViewDidShow() -> ((Bool) -> Void)?
    {
        return (self.mode == .Month) ? self.nextMonthViewDidShow() : self.nextWeekViewDidShow()
    }
}

// MARK: - Month Views

extension GCCalendarView
{
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
    
    // MARK: Add Month Views
    
    private func addMonthViews()
    {
        let currentMonthComponents = self.viewController.calendar.components([.Day, .Month, .Year], fromDate: self.viewController.selectedDate)
        currentMonthComponents.day = 1
        
        let currentMonthStartDate = self.viewController.calendar.dateFromComponents(currentMonthComponents)!
        let previousMonthStartDate = self.previousMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        let nextMonthStartDate = self.nextMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        
        for startDate in [previousMonthStartDate, currentMonthStartDate, nextMonthStartDate]
        {
            let monthView = GCCalendarMonthView(viewController: self.viewController, startDate: startDate)
            monthView.addPanGestureRecognizer(self, action: #selector(self.toggleCurrentView(_:)))
            
            self.addSubview(monthView)
            self.monthViews.append(monthView)
            
            let top = NSLayoutConstraint(item: monthView, attribute: .Top, relatedBy: .Equal, toItem: self.headerView, attribute: .Bottom, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: monthView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
            let width = NSLayoutConstraint(item: monthView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0)
            
            self.addConstraints([top, bottom, width])
        }
        
        self.resetLayout()
    }
    
    // MARK: Remove Month Views
    
    private func removeMonthViews()
    {
        for monthView in self.monthViews
        {
            monthView.removeFromSuperview()
        }
        
        self.monthViews.removeAll()
    }
    
    // MARK: Start Dates
    
    private func previousMonthStartDate(currentMonthStartDate currentMonthStartDate: NSDate) -> NSDate
    {
        return self.viewController.calendar.dateByAddingUnit(.Month, value: -1, toDate: currentMonthStartDate, options: .MatchStrictly)!
    }
    
    private func nextMonthStartDate(currentMonthStartDate currentMonthStartDate: NSDate) -> NSDate
    {
        return self.viewController.calendar.nextDateAfterDate(currentMonthStartDate, matchingUnit: .Day, value: 1, options: .MatchStrictly)!
    }
    
    // MARK: Show Month View
    
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
}

// MARK: - Week Views

extension GCCalendarView
{
    // MARK: Properties
    
    private var previousWeekView: GCCalendarWeekView {
        
        return self.weekViews[0]
    }
    
    private var currentWeekView: GCCalendarWeekView {
        
        return self.weekViews[1]
    }
    
    private var nextWeekView: GCCalendarWeekView {
        
        return self.weekViews[2]
    }
    
    // MARK: Add Week Views
    
    private func addWeekViews()
    {
        let currentWeekDates = self.currentWeekDates()
        let previousWeekDates = self.previousWeekDates(currentWeekDates: currentWeekDates)
        let nextWeekDates = self.nextWeekDates(currentWeekDates: currentWeekDates)
        
        for dates in [previousWeekDates, currentWeekDates, nextWeekDates]
        {
            let weekView = GCCalendarWeekView(viewController: self.viewController, dates: dates)
            weekView.addPanGestureRecognizer(self, action: #selector(self.toggleCurrentView(_:)))
            
            self.addSubview(weekView)
            self.weekViews.append(weekView)
            
            let top = NSLayoutConstraint(item: weekView, attribute: .Top, relatedBy: .Equal, toItem: self.headerView, attribute: .Bottom, multiplier: 1, constant: 0)
            let width = NSLayoutConstraint(item: weekView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: weekView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 45)
            
            self.addConstraints([top, width, height])
        }
        
        self.resetLayout()
    }
    
    // MARK: Remove Week Views
    
    private func removeWeekViews()
    {
        for weekView in self.weekViews
        {
            weekView.removeFromSuperview()
        }
        
        self.weekViews.removeAll()
    }
    
    // MARK: Dates
    
    private func previousWeekDates(currentWeekDates currentWeekDates: [NSDate?]) -> [NSDate?]
    {
        let startDate = self.viewController.calendar.dateByAddingUnit(.WeekOfYear, value: -1, toDate: currentWeekDates.first!!, options: .MatchStrictly)
        
        return self.weekDates(startDate: startDate)
    }
    
    private func currentWeekDates() -> [NSDate?]
    {
        let components = self.viewController.calendar.components([.Weekday, .WeekOfYear, .Year], fromDate: self.viewController.selectedDate)
        components.weekday = 1
        
        let startDate = self.viewController.calendar.dateFromComponents(components)
        
        return self.weekDates(startDate: startDate)
    }
    
    private func nextWeekDates(currentWeekDates currentWeekDates: [NSDate?]) -> [NSDate?]
    {
        let startDate = self.viewController.calendar.dateByAddingUnit(.WeekOfYear, value: 1, toDate: currentWeekDates.first!!, options: .MatchStrictly)
        
        return self.weekDates(startDate: startDate)
    }
    
    private func weekDates(startDate startDate: NSDate?) -> [NSDate?]
    {
        var date: NSDate? = startDate
        
        let numberOfWeekdays = self.viewController.calendar.maximumRangeOfUnit(.Weekday).length
        
        var dates = [NSDate?](count: numberOfWeekdays, repeatedValue: nil)
        
        while date != nil
        {
            let dateComponents = self.viewController.calendar.components([.Weekday, .WeekOfYear, .Year], fromDate: date!)
            
            dates[dateComponents.weekday - 1] = date
            
            if let newDate = self.viewController.calendar.dateByAddingUnit(.Weekday, value: 1, toDate: date!, options: .MatchStrictly)
            {
                let newDateComponents = self.viewController.calendar.components(.WeekOfYear, fromDate: newDate)
                
                date = (newDateComponents.weekOfYear == dateComponents.weekOfYear) ? newDate : nil
            }
        }
        
        return dates
    }
    
    // MARK: Show Week View
    
    private func previousWeekViewDidShow() -> ((Bool) -> Void)?
    {
        return { finished in
            
            let newDates = self.previousWeekDates(currentWeekDates: self.previousWeekView.dates)
            
            self.nextWeekView.update(newDates: newDates)
            self.weekViews.insert(self.nextWeekView, atIndex: 0)
            self.weekViews.removeLast()
            
            self.resetLayout()
            self.setSelectedWeekViewDate()
        }
    }
    
    private func nextWeekViewDidShow() -> ((Bool) -> Void)?
    {
        return { finished in
            
            let newDates = self.nextWeekDates(currentWeekDates: self.nextWeekView.dates)
            
            self.previousWeekView.update(newDates: newDates)
            self.weekViews.append(self.previousWeekView)
            self.weekViews.removeFirst()
            
            self.resetLayout()
            self.setSelectedWeekViewDate()
        }
    }
    
    // MARK: Selected Week View Date
    
    private func setSelectedWeekViewDate()
    {
        let todayComponents = self.viewController.calendar.components([.Weekday, .WeekOfYear], fromDate: NSDate())
        
        if self.viewController.calendar.isDate(self.currentWeekView.dates.first!!, equalToDate: NSDate(), toUnitGranularity: .WeekOfYear)
        {
            self.currentWeekView.setSelectedDate(weekday: todayComponents.weekday)
        }
        else
        {
            let weekday = self.viewController.calendar.component(.Weekday, fromDate: self.viewController.selectedDate)
            
            self.currentWeekView.setSelectedDate(weekday: weekday)
        }
    }
}
