//
//  GCCalendarView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

public struct GCCalendarView: View {
    @EnvironmentObject var calendarData: GCCalendarData
    
    private var dates: [[Date?]] {
        return GCCalendar.datesForMonth(withDate: self.calendarData.selectedDate, inCalendar: self.calendarData.calendar)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            GCCalendarHeaderView()
                .environmentObject(self.calendarData)
            GCCalendarMonthView(dates: self.dates)
                .environmentObject(self.calendarData)
        }
    }
    
    public init() {}
}

#if DEBUG
struct GCCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .environmentObject(GCCalendarData())
            .frame(maxHeight: 370)
            .padding(10)
    }
}
#endif
