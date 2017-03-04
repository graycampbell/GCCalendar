//
//  GCCalendarDayView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//

import UIKit

private enum GCCalendarDayType {
    
    case past, current, future, none
}

// MARK: Properties & Initializers

internal final class GCCalendarDayView: UIView {
    
    // MARK: Properties
    
    fileprivate let viewController: GCCalendarViewController!
    
    internal var date: Date?
    fileprivate let button = UIButton()
    fileprivate let buttonWidth: CGFloat = 35
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    
    fileprivate var dayType: GCCalendarDayType = .none {
        
        didSet {
            
            self.formatButton()
        }
    }
    
    fileprivate var font: UIFont? {
        
        switch self.dayType {
            
            case .past:
                return self.viewController.pastDayViewFont()
                
            case .current:
                return self.viewController.currentDayViewFont()
                
            case .future:
                return self.viewController.futureDayViewFont()
                
            default:
                return nil
        }
    }
    
    fileprivate var textColor: UIColor? {
        
        switch self.dayType {
            
            case .past:
                return self.viewController.pastDaysEnabled() ? self.viewController.pastDayViewEnabledTextColor() : self.viewController.pastDayViewDisabledTextColor()
                
            case .current:
                return self.viewController.currentDayViewTextColor()
                
            case .future:
                return self.viewController.futureDayViewTextColor()
                
            default:
                return nil
        }
    }
    
    fileprivate var selectedFont: UIFont? {
        
        switch self.dayType {
            
            case .past:
                return self.viewController.pastDayViewSelectedFont()
                
            case .current:
                return self.viewController.currentDayViewSelectedFont()
                
            case .future:
                return self.viewController.futureDayViewSelectedFont()
                
            default:
                return nil
        }
    }
    
    fileprivate var selectedTextColor: UIColor? {
        
        switch self.dayType {
            
            case .past:
                return self.viewController.pastDayViewSelectedTextColor()
                
            case .current:
                return self.viewController.currentDayViewSelectedTextColor()
                
            case .future:
                return self.viewController.futureDayViewSelectedTextColor()
                
            default:
                return nil
        }
    }
    
    fileprivate var selectedBackgroundColor: UIColor? {
        
        switch self.dayType {
            
            case .past:
                return self.viewController.pastDayViewSelectedBackgroundColor()
                
            case .current:
                return self.viewController.currentDayViewSelectedBackgroundColor()
                
            case .future:
                return self.viewController.futureDayViewSelectedBackgroundColor()
                
            default:
                return nil
        }
    }
    
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder) {
        
        return nil
    }
    
    internal init(viewController: GCCalendarViewController, date: Date?) {
        
        self.viewController = viewController
        
        super.init(frame: CGRect.zero)
        
        self.addButton()
        self.update(newDate: date)
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selected))
        
        self.addGestureRecognizer(self.tapGestureRecognizer)
    }
}

// MARK: - Button

private extension GCCalendarDayView {
    
    // MARK: Creation
    
    func addButton() {
        
        self.button.layer.cornerRadius = self.buttonWidth / 2
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.addTarget(self, action: #selector(self.selected), for: .touchUpInside)
        
        self.addSubview(self.button)
        self.addButtonConstraints()
    }
    
    func formatButton() {
        
        self.button.titleLabel!.font = self.font
        self.button.setTitleColor(self.textColor, for: .normal)
    }
    
    // MARK: Constraints
    
    func addButtonConstraints() {
        
        let width = NSLayoutConstraint(item: self.button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.buttonWidth)
        let height = NSLayoutConstraint(item: self.button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.buttonWidth)
        let centerX = NSLayoutConstraint(item: self.button, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self.button, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraints([width, height, centerX, centerY])
    }
}

// MARK: - Date

internal extension GCCalendarDayView {
    
    internal func update(newDate: Date?) {
        
        self.date = newDate
        
        if self.date == nil {
            
            self.button.isEnabled = false
            self.button.setTitle(nil, for: .normal)
            
            self.dayType = .none
        }
        else {
            
            let title = GCDateFormatter.stringFromDate(self.date!, withFormat: "d", andCalendar: self.viewController.calendar)
            
            self.button.isEnabled = true
            self.button.setTitle(title, for: .normal)
            
            if self.viewController.calendar.isDateInToday(self.date!) {
                
                self.dayType = .current
            }
            else if (Date() as NSDate).earlierDate(self.date!) == self.date! {
                
                self.dayType = .past
            }
            else {
                
                self.dayType = .future
            }
            
            self.viewController.calendar.isDate(self.date!, inSameDayAs: self.viewController.selectedDate) ? self.selected() : self.deselected()
        }
    }
}

// MARK: - Selection

internal extension GCCalendarDayView {
    
    internal func selected() {
        
        if self.date != nil && !(self.dayType == .past && !self.viewController.pastDaysEnabled()) {
            
            self.viewController.selectedDayView?.deselected()
            
            self.button.backgroundColor = self.selectedBackgroundColor
            self.button.titleLabel!.font = self.selectedFont
            self.button.setTitleColor(self.selectedTextColor, for: .normal)
            
            self.viewController.didSelectDayView(self)
            
            self.animateSelection()
        }
    }
    
    internal func deselected() {
        
        self.button.backgroundColor = nil
        
        self.button.titleLabel!.font = self.font
        self.button.setTitleColor(self.textColor, for: .normal)
    }
}

// MARK: - Animations

private extension GCCalendarDayView {
    
    func animateSelection() {
        
        self.animateToScale(0.9) { finished in self.animateToScale(1.1) { finished in self.animateToScale(1.0) } }
    }
    
    func animateToScale(_ scale: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.button.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }, completion: completion)
    }
}
