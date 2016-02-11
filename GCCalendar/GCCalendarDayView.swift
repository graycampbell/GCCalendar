//
//  GCCalendarDayView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

internal final class GCCalendarDayView: UIView
{
    // MARK: - Properties
    
    private var viewController: GCCalendarViewController!
    
    private var date: NSDate?
    private let button = UIButton()
    private let buttonWidth: CGFloat = 35
    
    private var isSelectedDay: Bool = false {
        
        didSet { self.isSelectedDay ? self.daySelected() : self.dayDeselected() }
    }
    
    private var isToday: Bool = false {
        
        didSet {
            
            self.button.titleLabel!.font = self.defaultFont
            self.button.setTitleColor(self.defaultTextColor, forState: .Normal)
        }
    }
}

// MARK: - Font, Text Color, & Background Color

internal extension GCCalendarDayView
{
    private var defaultFont: UIFont {
        
        return self.isToday ? self.viewController.currentDayViewFont() : self.viewController.dayViewFont()
    }
    
    private var selectedFont: UIFont {
        
        return self.isToday ? self.viewController.currentDayViewSelectedFont() : self.viewController.dayViewSelectedFont()
    }
    
    private var defaultTextColor: UIColor {
        
        return self.isToday ? self.viewController.currentDayViewTextColor() : self.viewController.dayViewTextColor()
    }
    
    private var selectedTextColor: UIColor {
        
        return self.isToday ? self.viewController.currentDayViewSelectedTextColor() : self.viewController.dayViewSelectedTextColor()
    }
    
    private var selectedBackgroundColor: UIColor {
        
        return self.isToday ? self.viewController.currentDayViewSelectedBackgroundColor() : self.viewController.dayViewSelectedBackgroundColor()
    }
}

// MARK: - Initializers

internal extension GCCalendarDayView
{
    internal convenience init(viewController: GCCalendarViewController, date: NSDate?)
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        
        self.addButton()
        self.update(newDate: date)
    }
}

// MARK: - Button

internal extension GCCalendarDayView
{
    private func addButton()
    {
        self.button.layer.cornerRadius = self.buttonWidth / 2
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.button)
        self.addButtonConstraints()
    }
    
    private func addButtonConstraints()
    {
        let width = NSLayoutConstraint(i: self.button, a: .Width, c: self.buttonWidth)
        let height = NSLayoutConstraint(i: self.button, a: .Height, c: self.buttonWidth)
        let centerX = NSLayoutConstraint(i: self.button, a: .CenterX, i: self)
        let centerY = NSLayoutConstraint(i: self.button, a: .CenterY, i: self)
        
        self.addConstraints([width, height, centerX, centerY])
    }
}

// MARK: - Date

internal extension GCCalendarDayView
{
    internal func update(newDate newDate: NSDate?)
    {
        self.date = newDate
        
        if self.date == nil
        {
            self.button.setTitle(nil, forState: .Normal)
            self.button.removeTarget(self, action: "dayPressed", forControlEvents: .TouchUpInside)
            
            self.isToday = false
            self.isSelectedDay = false
        }
        else
        {
            let title = GCDateFormatter.stringFromDate(self.date!, withFormat: "d", andCalendar: self.viewController.currentCalendar)
            
            self.button.setTitle(title, forState: .Normal)
            self.button.addTarget(self, action: "dayPressed", forControlEvents: .TouchUpInside)
            
            self.isToday = self.viewController.currentCalendar.isDateInToday(self.date!)
            self.isSelectedDay = self.viewController.currentCalendar.isDate(self.date!, inSameDayAsDate: self.viewController.selectedDate)
        }
    }
}

// MARK: - Selection

internal extension GCCalendarDayView
{
    internal func dayPressed()
    {
        self.isSelectedDay = true
    }
    
    private func daySelected()
    {
        self.button.enabled = false
        
        self.viewController.selectedDayView?.dayDeselected()
        
        self.viewController.selectedDayView = self
        self.viewController.selectedDate = self.date!
        
        self.button.backgroundColor = self.selectedBackgroundColor
        self.button.titleLabel!.font = self.selectedFont
        self.button.setTitleColor(self.selectedTextColor, forState: .Normal)
        
        self.viewController.didSelectDate(self.date!)
        
        self.animateSelection()
    }
    
    private func dayDeselected()
    {
        self.button.backgroundColor = nil
        
        let font = self.isToday ? self.viewController.currentDayViewFont() : self.viewController.dayViewFont()
        let titleColor = self.isToday ? self.viewController.currentDayViewTextColor() : self.viewController.dayViewTextColor()
        
        self.button.titleLabel!.font = font
        self.button.setTitleColor(titleColor, forState: .Normal)
        
        self.button.enabled = true
    }
}

// MARK: Animations

internal extension GCCalendarDayView
{
    private func animateSelection()
    {
        self.animateToScale(0.9) { finished in self.animateToScale(1.1) { finished in self.animateToScale(1.0) } }
    }
    
    private func animateToScale(scale: CGFloat, completion: ((Bool) -> Void)? = nil)
    {
        UIView.animateWithDuration(0.1, animations: {
            
            self.button.transform = CGAffineTransformMakeScale(scale, scale)
            
        }, completion: completion)
    }
}
