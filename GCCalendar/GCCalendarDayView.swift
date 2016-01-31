//
//  GCCalendarDayView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarDayView: UIButton
{
    // MARK: - Properties
    
    var date: NSDate?
    
    var isSelectedDay: Bool = false {
        
        didSet { self.isSelectedDay ? self.daySelected() : self.dayDeselected() }
    }
    
    var isToday: Bool = false {
        
        didSet {
            
            self.titleLabel!.font = self.defaultFont
            self.setTitleColor(self.defaultTextColor, forState: .Normal)
        }
    }
    
    var widthConstraint, heightConstraint, centerXConstraint, centerYConstraint: NSLayoutConstraint!
}

// MARK: Font & Text Color

extension GCCalendarDayView
{
    var defaultFont: UIFont {
        
        return self.isToday ? Calendar.CurrentDayView.font : Calendar.DayView.font
    }
    
    var selectedFont: UIFont {
        
        return self.isToday ? Calendar.CurrentDayView.selectedFont : Calendar.DayView.selectedFont
    }
    
    var defaultTextColor: UIColor {
        
        return self.isToday ? Calendar.CurrentDayView.textColor : Calendar.DayView.textColor
    }
    
    var selectedTextColor: UIColor {
        
        return self.isToday ? Calendar.CurrentDayView.selectedTextColor : Calendar.DayView.selectedTextColor
    }
}

// MARK: - Initializers

extension GCCalendarDayView
{
    public convenience init(date: NSDate?)
    {
        self.init(frame: CGRectZero)
        
        self.addDate(date)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Date

extension GCCalendarDayView
{
    func addDate(date: NSDate?)
    {
        self.date = date
        
        if self.date != nil
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "d"
            
            if dateFormatter.calendar != Calendar.currentCalendar
            {
                dateFormatter.calendar = Calendar.currentCalendar
            }
            
            let title = dateFormatter.stringFromDate(self.date!)
            
            self.setTitle(title, forState: .Normal)
            
            self.addTarget(self, action: "dayPressed", forControlEvents: .TouchUpInside)
            
            self.isToday = Calendar.currentCalendar.isDateInToday(self.date!)
            self.isSelectedDay = self.isToday
        }
    }
}

// MARK: - Selection

extension GCCalendarDayView
{
    func dayPressed()
    {
        self.isSelectedDay = true
    }
    
    private func daySelected()
    {
        self.enabled = false
        
        Calendar.selectedDayView?.dayDeselected()
        
        Calendar.selectedDayView = self
        
        self.backgroundColor = Calendar.CurrentDayView.selectedBackgroundColor
        
        self.titleLabel!.font = Calendar.CurrentDayView.selectedFont
        
        self.setTitleColor(Calendar.CurrentDayView.selectedTextColor, forState: .Normal)
        
        self.animateSelection()
    }
    
    private func dayDeselected()
    {
        self.backgroundColor = nil
        
        let font = self.isToday ? Calendar.CurrentDayView.font : Calendar.DayView.font
        let titleColor = self.isToday ? Calendar.CurrentDayView.textColor : Calendar.DayView.textColor
        
        self.titleLabel!.font = font
        
        self.setTitleColor(titleColor, forState: .Normal)
        
        self.enabled = true
    }
}

// MARK: Animations

extension GCCalendarDayView
{
    private func animateSelection()
    {
        self.animateToScale(0.9) { finished in
            
            if finished
            {
                self.animateToScale(1.1) { finished in
                    
                    if finished
                    {
                        self.animateToScale(1.0, completion: nil)
                    }
                }
            }
        }
    }
    
    private func animateToScale(scale: CGFloat, completion: ((Bool) -> Void)?)
    {
        UIView.animateWithDuration(0.1, animations: {
            
            self.transform = CGAffineTransformMakeScale(scale, scale)
            
            }, completion: completion)
    }
}
