![banner](Screenshots/Banner.png)

### CocoaPods

To install GCCalendar, paste the code shown below into your project's Podfile, and then run `pod install` from the command line. For more information about installing dependencies using CocoaPods, please visit this [link](https://cocoapods.org/#get_started).

`pod "GCCalendar", git: "https://github.com/graycampbell/GCCalendar.git"`

Once you've installed GCCalendar, you'll need to link the GCCalendar framework to your project and add `import GCCalendar` to your import statements.

### Usage

1. Create a subclass of GCCalendarViewController

   **GCCalendarViewController has a property called `calendarView` that is already added to the view, so you don't need to create it yourself or add it as a subview.**

2. Set the calendar view's frame or add layout constraints

   **If you're using layout constraints, make sure to add `self.calendarView.translatesAutoresizingMaskIntoConstraints = false` to your code.**

3. Customize!
