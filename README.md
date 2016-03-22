![banner](Screenshots/Banner.png)

### Overview

1. [CocoaPods](https://github.com/graycampbell/GCCalendar#cocoapods)
2. [Properties](https://github.com/graycampbell/GCCalendar#properties)
3. [View Setup](https://github.com/graycampbell/GCCalendar#view-setup)
4. [Date Selection](https://github.com/graycampbell/GCCalendar#date-selection)
5. [Calendar Modes](https://github.com/graycampbell/GCCalendar#calendar-modes)
6. [Customization](https://github.com/graycampbell/GCCalendar#customization)

### CocoaPods

To install GCCalendar, paste the code shown below into your project's Podfile, and then run `pod install` from the command line. For more information about installing dependencies using CocoaPods, please visit this [link](https://cocoapods.org/#get_started).

```
pod "GCCalendar", git: "https://github.com/graycampbell/GCCalendar.git"
```

Once you've installed GCCalendar, you'll need to link the GCCalendar framework to your project and add `import GCCalendar` to your import statements.

### Properties

```
public var selectedDate: NSDate!
public var calendarView: GCCalendarView!
```

### View Setup

1. Create a subclass of GCCalendarViewController

   **GCCalendarViewController has a property called `calendarView` that is already added to the view, so you don't need to create it yourself or add it as a subview.**

2. Set the calendar view's frame or add layout constraints

   **Remember to include `self.calendarView.translatesAutoresizingMaskIntoConstraints = false` if using layout constraints.**

3. Customize!

### Date Selection

```
override func didSelectDate(date: NSDate)
{
    super.didSelectDate(date)

    // Add custom implementation here
}
```

### Calendar Modes

```
self.calendarView.changeMode(.Week)
self.calendarView.changeMode(.Month)
```

```
override func shouldAutomaticallyChangeModeOnOrientationChange() -> Bool
```

### Customization

  ```
  override func weekdayLabelFont() -> UIFont
  override func weekdayLabelTextColor() -> UIColor

  override func pastDaysEnabled() -> Bool
  override func pastDayViewFont() -> UIFont
  override func pastDayViewEnabledTextColor() -> UIColor
  override func pastDayViewDisabledTextColor() -> UIColor
  override func pastDayViewSelectedFont() -> UIFont
  override func pastDayViewSelectedTextColor() -> UIColor
  override func pastDayViewSelectedBackgroundColor() -> UIColor

  override func currentDayViewFont() -> UIFont
  override func currentDayViewTextColor() -> UIColor
  override func currentDayViewSelectedFont() -> UIFont
  override func currentDayViewSelectedTextColor() -> UIColor
  override func currentDayViewSelectedBackgroundColor() -> UIColor

  override func futureDayViewFont() -> UIFont
  override func futureDayViewTextColor() -> UIColor
  override func futureDayViewSelectedFont() -> UIFont
  override func futureDayViewSelectedTextColor() -> UIColor
  override func futureDayViewSelectedBackgroundColor() -> UIColor
  ```
