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
    
    var widthConstraint, heightConstraint, centerXConstraint, centerYConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers
    
    public required init?(coder aDecoder: NSCoder)
    {
        fatalError("GCCalendar does not support NSCoding.")
    }
    
    public init()
    {
        super.init(frame: CGRectZero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle("16", forState: .Normal)
        self.setTitleColor(Calendar.DayView.enabledTextColor, forState: .Normal)
        
        self.titleLabel!.font = Calendar.DayView.enabledFont
        
        self.addTarget(self, action: "daySelected", forControlEvents: .TouchUpInside)
    }
}

// MARK: - Day Selected

extension GCCalendarDayView
{
    func daySelected()
    {
        self.backgroundColor = Calendar.CurrentDayView.selectedBackgroundColor
        
        self.titleLabel!.font = Calendar.CurrentDayView.selectedFont
        
        self.setTitleColor(Calendar.CurrentDayView.selectedTextColor, forState: .Normal)
        
        self.animate()
    }
    
    func animate()
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
    
    func animateToScale(scale: CGFloat, completion: ((Bool) -> Void)?)
    {
        UIView.animateWithDuration(0.1, animations: {
        
            self.transform = CGAffineTransformMakeScale(scale, scale)
            
        }, completion: completion)
    }
}
