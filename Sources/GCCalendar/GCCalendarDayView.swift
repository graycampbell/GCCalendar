//
//  GCCalendarDayView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarDayView: View {
    @State var date: Date?
    @Binding var calendar: Calendar
    
    private var title: String {
        return GCCalendar.string(fromDate: self.date, withFormat: "d", inCalendar: self.calendar)
    }
    
    private var isSelectedDate: Bool {
        return GCCalendar.isDate(self.date, inSameDayAs: Date(), inCalendar: self.calendar)
    }
    
    var body: some View {
        Button(action: {}) {
            VStack {
                Spacer(minLength: 0)
                HStack {
                    Spacer(minLength: 0)
                    Text(self.title)
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
            }
        }
        .background(self.isSelectedDate ? Color.accentColor : Color.white)
        .foregroundColor(self.isSelectedDate ? .white : .black)
        .mask(Circle())
    }
}

#if DEBUG
struct GCCalendarDayView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .frame(maxHeight: 370)
    }
}
#endif
