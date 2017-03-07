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
    
    fileprivate let configuration: GCCalendarConfiguration
    
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
                return self.configuration.appearance.pastDayViewFont
                
            case .current:
                return self.configuration.appearance.currentDayViewFont
                
            case .future:
                return self.configuration.appearance.futureDayViewFont
                
            case .none:
                return nil
        }
    }
    
    fileprivate var textColor: UIColor? {
        
        switch self.dayType {
            
            case .past:
                return self.configuration.appearance.pastDaysEnabled ? self.configuration.appearance.pastDayViewEnabledTextColor : self.configuration.appearance.pastDayViewDisabledTextColor
                
            case .current:
                return self.configuration.appearance.currentDayViewTextColor
                
            case .future:
                return self.configuration.appearance.futureDayViewTextColor
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedFont: UIFont? {
        
        switch self.dayType {
            
            case .past:
                return self.configuration.appearance.pastDayViewSelectedFont
                
            case .current:
                return self.configuration.appearance.currentDayViewSelectedFont
                
            case .future:
                return self.configuration.appearance.futureDayViewSelectedFont
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedTextColor: UIColor? {
        
        switch self.dayType {
            
            case .past:
                return self.configuration.appearance.pastDayViewSelectedTextColor
                
            case .current:
                return self.configuration.appearance.currentDayViewSelectedTextColor
                
            case .future:
                return self.configuration.appearance.futureDayViewSelectedTextColor
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedBackgroundColor: UIColor? {
        
        switch self.dayType {
            
            case .past:
                return self.configuration.appearance.pastDayViewSelectedBackgroundColor
                
            case .current:
                return self.configuration.appearance.currentDayViewSelectedBackgroundColor
                
            case .future:
                return self.configuration.appearance.futureDayViewSelectedBackgroundColor
                
            case .none:
                return nil
        }
    }
    
    var date: Date? {
        
        didSet {
            
            if self.date == nil {
                
                self.button.isEnabled = false
                self.button.setTitle(nil, for: .normal)
                
                self.dayType = .none
            }
            else {
                
                let title = GCDateFormatter.string(fromDate: self.date!, withFormat: "d", andCalendar: self.configuration.calendar)
                
                self.button.isEnabled = true
                self.button.setTitle(title, for: .normal)
                
                if self.configuration.calendar.isDateInToday(self.date!) {
                    
                    self.dayType = .current
                }
                else if (Date() as NSDate).earlierDate(self.date!) == self.date! {
                    
                    self.dayType = .past
                }
                else {
                    
                    self.dayType = .future
                }
                
                self.configuration.calendar.isDate(self.date!, inSameDayAs: self.configuration.selectedDate()) ? self.highlight() : self.unhighlight()
            }
        }
    }
    
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder) {
        
        return nil
    }
    
    internal init(configuration: GCCalendarConfiguration) {
        
        self.configuration = configuration
        
        super.init(frame: CGRect.zero)
        
        self.addButton()
        self.addTapGestureRecognizer()
    }
}

// MARK: - Button

private extension GCCalendarDayView {
    
    // MARK: Creation
    
    func addButton() {
        
        self.button.layer.cornerRadius = self.buttonWidth / 2
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.addTarget(self, action: #selector(self.highlight), for: .touchUpInside)
        
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

// MARK: - Tap Gesture Recognizer

fileprivate extension GCCalendarDayView {
    
    fileprivate func addTapGestureRecognizer() {
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.highlight))
        
        self.addGestureRecognizer(self.tapGestureRecognizer)
    }
}

// MARK: - Selection

internal extension GCCalendarDayView {
    
    internal func highlight() {
        
        if self.date != nil && !(self.dayType == .past && !self.configuration.appearance.pastDaysEnabled) {
            
            self.button.backgroundColor = self.selectedBackgroundColor
            self.button.titleLabel!.font = self.selectedFont
            self.button.setTitleColor(self.selectedTextColor, for: .normal)
            
            self.configuration.dayViewSelected?(self)
            
            self.animateSelection()
        }
    }
    
    internal func unhighlight() {
        
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
