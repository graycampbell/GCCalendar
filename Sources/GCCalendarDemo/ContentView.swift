//
//  ContentView.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 7/4/19.
//

import SwiftUI
import GCCalendar

struct ContentView: View {
    @State var calendarData = GCCalendarData()
    @State var selectedColor = Color.red
    
    private var colors: [Color] = [.red, .blue, .orange, .green]
    
    private var title: String {
        return GCCalendar.string(fromDate: self.calendarData.selectedDate, withTemplate: "MMMM yyyy", inCalendar: self.calendarData.calendar)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                GCCalendarView()
                    .accentColor(self.selectedColor)
                    .environmentObject(self.calendarData)
                    .navigationBarTitle(Text(self.title))
                    .frame(height: 325)
                SegmentedControl(selection: self.$selectedColor) {
                    ForEach(self.colors.identified(by: \.self)) { color in
                        Text(color.description.capitalized)
                    }
                }
                Spacer()
            }
            .padding(10)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
