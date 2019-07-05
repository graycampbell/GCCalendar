//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarMonthView: View {
    @EnvironmentObject var calendarData: GCCalendarData
    
    @State var dates: [[Date?]]
    
    var body: some View {
        ForEach(0..<self.dates.count) { index in
            GCCalendarWeekView(dates: self.dates[index])
                .environmentObject(self.calendarData)
                .tag(index)
        }
    }
}

#if DEBUG
struct GCCalendarMonthView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .environmentObject(GCCalendarData())
            .frame(maxHeight: 370)
            .padding(10)
    }
}
#endif
