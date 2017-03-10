//
//  CalendarViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit
import GCCalendar

// MARK: Properties & Initializers

class CalendarViewController: UIViewController {
    
    // MARK: Properties
    
    fileprivate var calendarView: GCCalendarView!
}

// MARK: - View

extension CalendarViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tintColor = UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        
        self.navigationController!.toolbar.tintColor = tintColor
        self.navigationController!.navigationBar.tintColor = tintColor
        
        self.addToolbar()
        self.addCalendarView()
        self.addConstraints()
    }
}

// MARK: - Toolbar

extension CalendarViewController {
    
    fileprivate func addToolbar() {
        
        self.navigationController!.isToolbarHidden = false
        
        let today = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.today))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let displayMode = UIBarButtonItem(title: "Display Mode", style: .plain, target: self, action: #selector(self.displayMode))
        
        self.toolbarItems = [today, space, displayMode]
    }
    
    // MARK: Targets
    
    func today() {
        
        self.calendarView.today()
    }
    
    func displayMode() {
        
        self.calendarView.displayMode = (self.calendarView.displayMode == .month) ? .week : .month
    }
}

// MARK: - Calendar View

fileprivate extension CalendarViewController {
    
    fileprivate func addCalendarView() {
        
        self.calendarView = GCCalendarView()
        
        self.calendarView.delegate = self
        self.calendarView.displayMode = .month
        
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.calendarView)
    }
}

// MARK: - Constraints

fileprivate extension CalendarViewController {
    
    fileprivate func addConstraints() {
        
        self.calendarView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 12).isActive = true
        self.calendarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.calendarView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.calendarView.heightAnchor.constraint(equalToConstant: 325).isActive = true
    }
}

// MARK: - GCCalendarViewDelegate

extension CalendarViewController: GCCalendarViewDelegate {
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMYYYY", options: 0, locale: .current)
        
        self.navigationItem.title = dateFormatter.string(from: date)
    }
}
