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
    
    private weak var viewController: GCCalendarViewController!
    
    internal var date: NSDate?
    private let button = UIButton()
    private let buttonWidth: CGFloat = 35
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private enum DayType
    {
        case Past, Current, Future, None
    }
    
    private var dayType: DayType = .None {
        
        didSet { self.formatButton() }
    }
}

// MARK: - Font, Text Color, & Background Color

internal extension GCCalendarDayView
{
    private var font: UIFont? {
        
        switch self.dayType
        {
            case .Past:
                return self.viewController.pastDayViewFont()
                
            case .Current:
                return self.viewController.currentDayViewFont()
            
            case .Future:
                return self.viewController.futureDayViewFont()
            
            default:
                return nil
        }
    }
    
    private var textColor: UIColor? {
        
        switch self.dayType
        {
            case .Past:
                return self.viewController.pastDaysEnabled() ? self.viewController.pastDayViewEnabledTextColor() : self.viewController.pastDayViewDisabledTextColor()
                
            case .Current:
                return self.viewController.currentDayViewTextColor()
                
            case .Future:
                return self.viewController.futureDayViewTextColor()
            
            default:
                return nil
        }
    }
    
    private var selectedFont: UIFont? {
        
        switch self.dayType
        {
            case .Past:
                return self.viewController.pastDayViewSelectedFont()
                
            case .Current:
                return self.viewController.currentDayViewSelectedFont()
                
            case .Future:
                return self.viewController.futureDayViewSelectedFont()
            
            default:
                return nil
        }
    }
    
    private var selectedTextColor: UIColor? {
        
        switch self.dayType
        {
            case .Past:
                return self.viewController.pastDayViewSelectedTextColor()
                
            case .Current:
                return self.viewController.currentDayViewSelectedTextColor()
                
            case .Future:
                return self.viewController.futureDayViewSelectedTextColor()
            
            default:
                return nil
        }
    }
    
    private var selectedBackgroundColor: UIColor? {
        
        switch self.dayType
        {
            case .Past:
                return self.viewController.pastDayViewSelectedBackgroundColor()
                
            case .Current:
                return self.viewController.currentDayViewSelectedBackgroundColor()
                
            case .Future:
                return self.viewController.futureDayViewSelectedBackgroundColor()
            
            default:
                return nil
        }
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
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "selected")
        
        self.addGestureRecognizer(self.tapGestureRecognizer)
    }
}

// MARK: - Button

internal extension GCCalendarDayView
{
    private func addButton()
    {
        self.button.layer.cornerRadius = self.buttonWidth / 2
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.addTarget(self, action: "selected", forControlEvents: .TouchUpInside)
        
        self.addSubview(self.button)
        self.addButtonConstraints()
    }
    
    private func addButtonConstraints()
    {
        let width = NSLayoutConstraint(item: self.button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: self.buttonWidth)
        let height = NSLayoutConstraint(item: self.button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: self.buttonWidth)
        let centerX = NSLayoutConstraint(item: self.button, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self.button, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        
        self.addConstraints([width, height, centerX, centerY])
    }
    
    private func formatButton()
    {
        self.button.titleLabel!.font = self.font
        self.button.setTitleColor(self.textColor, forState: .Normal)
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
            self.button.enabled = false
            self.button.setTitle(nil, forState: .Normal)
            
            self.dayType = .None
        }
        else
        {
            let title = GCDateFormatter.stringFromDate(self.date!, withFormat: "d", andCalendar: self.viewController.calendar)
            
            self.button.enabled = true
            self.button.setTitle(title, forState: .Normal)
            
            if self.viewController.calendar.isDateInToday(self.date!)
            {
                self.dayType = .Current
            }
            else if NSDate().earlierDate(self.date!).isEqualToDate(self.date!)
            {
                self.dayType = .Past
            }
            else
            {
                self.dayType = .Future
            }
            
            self.viewController.calendar.isDate(self.date!, inSameDayAsDate: self.viewController.selectedDate) ? self.selected() : self.deselected()
        }
    }
}

// MARK: - Selection

internal extension GCCalendarDayView
{
    internal func selected()
    {
        if self.date != nil && !(self.dayType == .Past && !self.viewController.pastDaysEnabled())
        {
            self.viewController.selectedDayView?.deselected()
            
            self.button.backgroundColor = self.selectedBackgroundColor
            self.button.titleLabel!.font = self.selectedFont
            self.button.setTitleColor(self.selectedTextColor, forState: .Normal)
            
            self.viewController.didSelectDayView(self)
            
            self.animateSelection()
        }
    }
    
    private func deselected()
    {
        self.button.backgroundColor = nil
        
        self.button.titleLabel!.font = self.font
        self.button.setTitleColor(self.textColor, forState: .Normal)
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
