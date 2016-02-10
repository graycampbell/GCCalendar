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
    
    private var delegate: GCCalendarDelegate?
    private var headerView = GCCalendarHeaderView()
    private var monthViews: [GCCalendarMonthView] = []
    
    private var panGestureStartLocation: CGFloat!
    
    // MARK: - Initializers
    
    public convenience init(delegate: GCCalendarDelegate?)
    {
        self.init(frame: CGRectZero)
        
        self.delegate = delegate
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
        let currentMonthComponents = Calendar.currentCalendar.components([.Day, .Month, .Year], fromDate: Calendar.selectedDate)
        currentMonthComponents.day = 1
        
        let currentMonthStartDate = Calendar.currentCalendar.dateFromComponents(currentMonthComponents)!
        let previousMonthStartDate = self.previousMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        let nextMonthStartDate = self.nextMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        
        for startDate in [previousMonthStartDate, currentMonthStartDate, nextMonthStartDate]
        {
            let monthView = GCCalendarMonthView(delegate: self, startDate: startDate)
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
        return Calendar.currentCalendar.dateByAddingUnit(.Month, value: -1, toDate: currentMonthStartDate, options: .MatchStrictly)!
    }
    
    private func nextMonthStartDate(currentMonthStartDate currentMonthStartDate: NSDate) -> NSDate
    {
        return Calendar.currentCalendar.nextDateAfterDate(currentMonthStartDate, matchingUnit: .Day, value: 1, options: .MatchStrictly)!
    }
    
    // MARK: - Toggle Current Month
    
    func toggleCurrentMonth(pan: UIPanGestureRecognizer)
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

// MARK: - GCCalendarMonthDelegate

extension GCCalendarView: GCCalendarDelegate
{
    public func didSelectDate(date: NSDate)
    {
        self.delegate?.didSelectDate(date)
    }
    
    // MARK: Day View
    
    public func dayViewFont() -> UIFont
    {
        let font = self.delegate?.dayViewFont?()
        
        return (font != nil) ? font! : UIFont.systemFontOfSize(17)
    }
    
    public func dayViewTextColor() -> UIColor
    {
        let textColor = self.delegate?.dayViewTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor.black(0.87)
    }
    
    public func dayViewSelectedFont() -> UIFont
    {
        let font = self.delegate?.dayViewSelectedFont?()
        
        return (font != nil) ? font! : UIFont.boldSystemFontOfSize(17)
    }
    
    public func dayViewSelectedTextColor() -> UIColor
    {
        let textColor = self.delegate?.dayViewSelectedTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor.whiteColor()
    }
    
    public func dayViewSelectedBackgroundColor() -> UIColor
    {
        let backgroundColor = self.delegate?.dayViewSelectedBackgroundColor?()
        
        return (backgroundColor != nil) ? backgroundColor! : UIColor.black(0.87)
    }
    
    // MARK: Past Day View
    
    public func pastDaysEnabled() -> Bool
    {
        let enabled = self.delegate?.pastDaysEnabled?()
        
        return (enabled != nil) ? enabled! : true
    }
    
    public func pastDayViewFont() -> UIFont
    {
        let font = self.delegate?.pastDayViewFont?()
        
        return (font != nil) ? font! : UIFont.systemFontOfSize(17)
    }
    
    public func pastDayViewEnabledTextColor() -> UIColor
    {
        let textColor = self.delegate?.pastDayViewEnabledTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor.black(0.87)
    }
    
    public func pastDayViewDisabledTextColor() -> UIColor
    {
        let textColor = self.delegate?.pastDayViewDisabledTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor(r: 146, g: 146, b: 146)
    }
    
    public func pastDayViewSelectedFont() -> UIFont
    {
        let font = self.delegate?.pastDayViewSelectedFont?()
        
        return (font != nil) ? font! : UIFont.boldSystemFontOfSize(17)
    }
    
    public func pastDayViewSelectedTextColor() -> UIColor
    {
        let textColor = self.delegate?.pastDayViewSelectedTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor.whiteColor()
    }
    
    public func pastDayViewSelectedBackgroundColor() -> UIColor
    {
        let backgroundColor = self.delegate?.pastDayViewSelectedBackgroundColor?()
        
        return (backgroundColor != nil) ? backgroundColor! : UIColor.black(0.87)
    }
    
    // MARK: Current Day View
    
    public func currentDayViewFont() -> UIFont
    {
        let font = self.delegate?.currentDayViewFont?()
        
        return (font != nil) ? font! : UIFont.boldSystemFontOfSize(17)
    }
    
    public func currentDayViewTextColor() -> UIColor
    {
        let textColor = self.delegate?.currentDayViewTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor(r: 255, g: 58, b: 48)
    }
    
    public func currentDayViewSelectedFont() -> UIFont
    {
        let font = self.delegate?.currentDayViewSelectedFont?()
        
        return (font != nil) ? font! : UIFont.boldSystemFontOfSize(17)
    }
    
    public func currentDayViewSelectedTextColor() -> UIColor
    {
        let textColor = self.delegate?.currentDayViewSelectedTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor.whiteColor()
    }
    
    public func currentDayViewSelectedBackgroundColor() -> UIColor
    {
        let backgroundColor = self.delegate?.currentDayViewSelectedBackgroundColor?()
        
        return (backgroundColor != nil) ? backgroundColor! : UIColor(r: 255, g: 58, b: 48)
    }
    
    // MARK: Future Day View
    
    public func futureDayViewFont() -> UIFont
    {
        let font = self.delegate?.futureDayViewFont?()
        
        return (font != nil) ? font! : UIFont.systemFontOfSize(17)
    }
    
    public func futureDayViewTextColor() -> UIColor
    {
        let textColor = self.delegate?.futureDayViewTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor.black(0.87)
    }
    
    public func futureDayViewSelectedFont() -> UIFont
    {
        let font = self.delegate?.futureDayViewSelectedFont?()
        
        return (font != nil) ? font! : UIFont.boldSystemFontOfSize(17)
    }
    
    public func futureDayViewSelectedTextColor() -> UIColor
    {
        let textColor = self.delegate?.futureDayViewSelectedTextColor?()
        
        return (textColor != nil) ? textColor! : UIColor.whiteColor()
    }
    
    public func futureDayViewSelectedBackgroundColor() -> UIColor
    {
        let backgroundColor = self.delegate?.futureDayViewSelectedBackgroundColor?()
        
        return (backgroundColor != nil) ? backgroundColor! : UIColor.black(0.87)
    }
}
