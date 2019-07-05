//
//  GCCalendarData.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/4/19.
//

import SwiftUI
import Combine

public final class GCCalendarData: BindableObject {
    public let didChange = PassthroughSubject<GCCalendarData, Never>()
    
    public var calendar: Calendar = .current {
        didSet {
            didChange.send(self)
        }
    }
    
    public var selectedDate: Date = Date() {
        didSet {
            didChange.send(self)
        }
    }
    
    public init() {}
}
