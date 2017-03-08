//
//  GCCalendarDayView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//

import UIKit

fileprivate enum GCCalendarDateType {
    
    case past, current, future, none
}

// MARK: Properties & Initializers

internal final class GCCalendarDayView: UIView {
    
    // MARK: Properties
    
    fileprivate let configuration: GCCalendarConfiguration
    
    fileprivate let button = UIButton()
    fileprivate let buttonDimension: CGFloat = 35
    
    fileprivate let tapGestureRecognizer = UITapGestureRecognizer()
    
    fileprivate var isEnabled: Bool {
        
        return (self.date != nil && !(self.dateType == .past && !self.configuration.appearance.pastDatesEnabled))
    }
    
    fileprivate var dateType: GCCalendarDateType = .none {
        
        didSet {
            
            self.formatButton()
        }
    }
    
    fileprivate var font: UIFont? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.appearance.pastDateFont
                
            case .current:
                return self.configuration.appearance.currentDateFont
                
            case .future:
                return self.configuration.appearance.futureDateFont
                
            case .none:
                return nil
        }
    }
    
    fileprivate var textColor: UIColor? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.appearance.pastDatesEnabled ? self.configuration.appearance.pastDateEnabledTextColor : self.configuration.appearance.pastDateDisabledTextColor
                
            case .current:
                return self.configuration.appearance.currentDateTextColor
                
            case .future:
                return self.configuration.appearance.futureDateTextColor
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedFont: UIFont? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.appearance.pastDateSelectedFont
                
            case .current:
                return self.configuration.appearance.currentDateSelectedFont
                
            case .future:
                return self.configuration.appearance.futureDateSelectedFont
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedTextColor: UIColor? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.appearance.pastDateSelectedTextColor
                
            case .current:
                return self.configuration.appearance.currentDateSelectedTextColor
                
            case .future:
                return self.configuration.appearance.futureDateSelectedTextColor
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedBackgroundColor: UIColor? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.appearance.pastDateSelectedBackgroundColor
                
            case .current:
                return self.configuration.appearance.currentDateSelectedBackgroundColor
                
            case .future:
                return self.configuration.appearance.futureDateSelectedBackgroundColor
                
            case .none:
                return nil
        }
    }
    
    var date: Date? {
        
        didSet {
            
            if self.date == nil {
                
                self.button.isEnabled = false
                self.button.setTitle(nil, for: .normal)
                
                self.dateType = .none
            }
            else {
                
                let title = GCDateFormatter.string(fromDate: self.date!, withFormat: "d", andCalendar: self.configuration.calendar)
                
                self.button.isEnabled = true
                self.button.setTitle(title, for: .normal)
                
                if self.configuration.calendar.isDateInToday(self.date!) {
                    
                    self.dateType = .current
                }
                else if (Date() as NSDate).earlierDate(self.date!) == self.date! {
                    
                    self.dateType = .past
                }
                else {
                    
                    self.dateType = .future
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
        
        self.addTapGestureRecognizer()
        
        self.addButton()
        self.addConstraints()
    }
}

// MARK: - Tap Gesture Recognizer

fileprivate extension GCCalendarDayView {
    
    fileprivate func addTapGestureRecognizer() {
        
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.highlight))
        
        self.addGestureRecognizer(self.tapGestureRecognizer)
    }
}

// MARK: - Button

fileprivate extension GCCalendarDayView {
    
    fileprivate func addButton() {
        
        self.button.layer.cornerRadius = self.buttonDimension / 2
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.addTarget(self, action: #selector(self.highlight), for: .touchUpInside)
        
        self.addSubview(self.button)
    }
    
    fileprivate func formatButton() {
        
        self.button.titleLabel!.font = self.font
        self.button.setTitleColor(self.textColor, for: .normal)
    }
}

// MARK: - Constraints

fileprivate extension GCCalendarDayView {
    
    fileprivate func addConstraints() {
        
        let width = self.button.widthAnchor.constraint(equalToConstant: self.buttonDimension)
        let height = self.button.heightAnchor.constraint(equalToConstant: self.buttonDimension)
        let centerX = self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerY = self.button.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        self.addConstraints([width, height, centerX, centerY])
    }
}

// MARK: - Selection

internal extension GCCalendarDayView {
    
    internal func highlight() {
        
        if self.isEnabled && self != self.configuration.selectedDayView() {
            
            self.button.backgroundColor = self.selectedBackgroundColor
            self.button.titleLabel!.font = self.selectedFont
            self.button.setTitleColor(self.selectedTextColor, for: .normal)
            
            self.configuration.dayViewSelected(self)
            
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

fileprivate extension GCCalendarDayView {
    
    fileprivate func animateSelection() {
        
        self.animate(toScale: 0.9) { finished in
            
            if finished {
                
                self.animate(toScale: 1.1) { finished in
                    
                    if finished {
                        
                        self.animate(toScale: 1.0)
                    }
                }
            }
        }
    }
    
    fileprivate func animate(toScale scale: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.button.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }, completion: completion)
    }
}
