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
        self.setTitleColor(UIColor.black(0.87), forState: .Normal)
        
        self.titleLabel!.font = UIFont.systemFontOfSize(17)
        
        self.addTarget(self, action: "daySelected", forControlEvents: .TouchUpInside)
    }
}

// MARK: - Day Selected

extension GCCalendarDayView
{
    func daySelected()
    {
        self.backgroundColor = UIColor.orangeColor()
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        self.titleLabel!.font = UIFont.boldSystemFontOfSize(17)
    }
}
