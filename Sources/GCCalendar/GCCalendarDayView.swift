//
//  GCCalendarDayView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarDayView: View {
    @EnvironmentObject var calendarData: GCCalendarData
    
    @State var date: Date?
    
    private var title: String {
        return GCCalendar.string(fromDate: self.date, withTemplate: "d", inCalendar: self.calendarData.calendar)
    }
    
    private var backgroundColor: Color {
        if self.isSelectedDate {
            return self.isToday ? .accentColor : .black
        }
        else {
            return .white
        }
    }
    
    private var textColor: Color {
        if self.isSelectedDate {
            return .white
        }
        else {
            return self.isToday ? .accentColor : .black
        }
    }
    
    private var isToday: Bool {
        return GCCalendar.isDate(self.date, inSameDayAs: Date(), inCalendar: self.calendarData.calendar)
    }
    
    private var isSelectedDate: Bool {
        return GCCalendar.isDate(self.date, inSameDayAs: self.calendarData.selectedDate, inCalendar: self.calendarData.calendar)
    }
    
    var body: some View {
        Button(action: self.action) {
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Text(self.title)
                        .background(
                            Circle()
                                .foregroundColor(self.backgroundColor)
                                .frame(width: 40, height: 40)
                        )
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
            }
        }
        .foregroundColor(self.textColor)
    }
    
    private func action() {
        guard let date = self.date else { return }
        
        self.$calendarData.selectedDate.value = date
    }
}

#if DEBUG
struct GCCalendarDayView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .environmentObject(GCCalendarData())
            .frame(maxHeight: 370)
            .padding(10)
    }
}
#endif
