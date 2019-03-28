//
//  GCCalendarDayView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//

import UIKit

// MARK: Enumerables

fileprivate enum GCCalendarDateType {
    
    case past, current, future, none
}

// MARK: - Properties & Initializers

internal final class GCCalendarDayView: UIView {
    
    // MARK: Properties
    
    fileprivate let configuration: GCCalendarConfiguration
    
    fileprivate let button = UIButton()
    fileprivate let buttonDimension: CGFloat = 35
    
    fileprivate let tapGestureRecognizer = UITapGestureRecognizer()
    
    fileprivate var dateType: GCCalendarDateType = .none {
        
        didSet {
            
            self.formatButton()
        }
    }
    
    fileprivate var title: String? {
        
        switch self.dateType {
            
            case .none:
                return nil
            
            default:
                let dateFormatter = DateFormatter()
                
                dateFormatter.calendar = self.configuration.calendar
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d", options: 0, locale: self.configuration.calendar.locale)
                
                return dateFormatter.string(from: self.date!)
        }
    }
    
    fileprivate var font: UIFont? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.pastDateFont
                
            case .current:
                return self.configuration.currentDateFont
                
            case .future:
                return self.configuration.futureDateFont
                
            case .none:
                return nil
        }
    }
    
    fileprivate var textColor: UIColor? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.pastDatesEnabled ? self.configuration.pastDateEnabledTextColor : self.configuration.pastDateDisabledTextColor
                
            case .current:
                return self.configuration.currentDateTextColor
                
            case .future:
                return self.configuration.futureDateTextColor
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedFont: UIFont? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.pastDateSelectedFont
                
            case .current:
                return self.configuration.currentDateSelectedFont
                
            case .future:
                return self.configuration.futureDateSelectedFont
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedTextColor: UIColor? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.pastDateSelectedTextColor
                
            case .current:
                return self.configuration.currentDateSelectedTextColor
                
            case .future:
                return self.configuration.futureDateSelectedTextColor
                
            case .none:
                return nil
        }
    }
    
    fileprivate var selectedBackgroundColor: UIColor? {
        
        switch self.dateType {
            
            case .past:
                return self.configuration.pastDateSelectedBackgroundColor
                
            case .current:
                return self.configuration.currentDateSelectedBackgroundColor
                
            case .future:
                return self.configuration.futureDateSelectedBackgroundColor
                
            case .none:
                return nil
        }
    }
    
    var date: Date? {
        
        didSet {
            
            if let newDate = self.date {
                
                if self.configuration.calendar.isDateInToday(newDate) {
                    
                    self.dateType = .current
                }
                else if newDate < Date() {
                    
                    self.dateType = .past
                }
                else {
                    
                    self.dateType = .future
                }
            }
            else {
                
                self.dateType = .none
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
    
    func addTapGestureRecognizer() {
        
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.highlight))
        
        self.addGestureRecognizer(self.tapGestureRecognizer)
    }
}

// MARK: - Button

fileprivate extension GCCalendarDayView {
    
    func addButton() {
        
        self.button.layer.cornerRadius = self.buttonDimension / 2
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.addTarget(self, action: #selector(self.highlight), for: .touchUpInside)
        
        self.addSubview(self.button)
    }
    
    func formatButton() {
        
        self.button.setTitle(self.title, for: .normal)
        self.button.setTitleColor(self.textColor, for: .normal)
        self.button.titleLabel!.font = self.font
        
        switch self.dateType {
            
            case .none:
                self.isUserInteractionEnabled = false
            
            default:
                self.isUserInteractionEnabled = true
            
                if self.configuration.calendar.isDate(self.date!, inSameDayAs: self.configuration.selectedDate()) {
                    
                    self.highlight()
                }
                else {
                    
                    self.unhighlight()
                }
        }
    }
}

// MARK: - Constraints

fileprivate extension GCCalendarDayView {
    
    func addConstraints() {
        
        self.button.widthAnchor.constraint(equalToConstant: self.buttonDimension).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: self.buttonDimension).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

// MARK: - Selection

internal extension GCCalendarDayView {
    
    @objc func highlight() {
        
        if !(self.dateType == .past && !self.configuration.pastDatesEnabled) {
            
            self.isUserInteractionEnabled = false
            
            self.button.backgroundColor = self.selectedBackgroundColor
            self.button.titleLabel!.font = self.selectedFont
            self.button.setTitleColor(self.selectedTextColor, for: .normal)
            
            self.configuration.dayViewSelected(self)
            
            self.animateSelection()
        }
    }
    
    func unhighlight() {
        
        self.button.backgroundColor = nil
        
        self.button.titleLabel!.font = self.font
        self.button.setTitleColor(self.textColor, for: .normal)
        
        self.isUserInteractionEnabled = true
    }
}

// MARK: - Animations

fileprivate extension GCCalendarDayView {
    
    func animateSelection() {
        
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
    
    func animate(toScale scale: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.button.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }, completion: completion)
    }
}
