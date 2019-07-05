//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarWeekView: View {
    @EnvironmentObject var calendarData: GCCalendarData
    
    @State var dates: [Date?]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<self.dates.count) { index in
                GCCalendarDayView(date: self.dates[index])
                    .environmentObject(self.calendarData)
                    .tag(index)
            }
        }
    }
}

#if DEBUG
struct GCCalendarWeekView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .environmentObject(GCCalendarData())
            .frame(maxHeight: 370)
            .padding(10)
    }
}
#endif
