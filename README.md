![banner](Resources/README/Assets/Banner.png)

[![Release](https://img.shields.io/github/release/graycampbell/GCCalendar.svg)](https://github.com/graycampbell/GCCalendar/releases/latest)
[![CocoaPods](https://img.shields.io/cocoapods/v/GCCalendar.svg)](https://cocoapods.org/pods/GCCalendar)
[![Documentation](https://img.shields.io/badge/docs-100%25-brightgreen.svg)](https://graycampbell.github.io/GCCalendar)
[![Codacy Code Quality](https://img.shields.io/codacy/grade/7ef16773008b4ed9b7798dd3d0da54af.svg)](https://www.codacy.com/app/graycampbell/GCCalendar?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=graycampbell/GCCalendar&amp;utm_campaign=Badge_Grade)
[![Swift 4 Compatible](https://img.shields.io/badge/Swift_4-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
![Platform](https://img.shields.io/cocoapods/p/GCCalendar.svg?style=flat)
[![License](https://img.shields.io/cocoapods/l/GCCalendar.svg)](https://github.com/graycampbell/GCCalendar/blob/master/LICENSE)

### CocoaPods

```
pod 'GCCalendar'
```

### Implementation

1. Add GCCalendar to your file's import statements.

    ```
    import GCCalendar
    ```

2. Create an instance of GCCalendarView.

    ```
    let calendarView = GCCalendarView()
    ```

3. Set the delegate and the display mode. If you don't set the delegate and the display mode, the calendar will not appear.

    ```
    calendarView.delegate = self
    calendarView.displayMode = .month
    ```

4. Implement GCCalendarViewDelegate.

    ```
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar)
    ```

### Documentation

- [Classes](https://graycampbell.github.io/GCCalendar/Classes.html)
  - [GCCalendarView](https://graycampbell.github.io/GCCalendar/Classes/GCCalendarView.html)

- [Enums](https://graycampbell.github.io/GCCalendar/Enums.html)
  - [GCCalendarDisplayMode](https://graycampbell.github.io/GCCalendar/Enums/GCCalendarDisplayMode.html)

- [Protocols](https://graycampbell.github.io/GCCalendar/Protocols.html)
  - [GCCalendarViewDelegate](https://graycampbell.github.io/GCCalendar/Protocols/GCCalendarViewDelegate.html)

### License

GCCalendar is available under the MIT license. See the [LICENSE](https://github.com/graycampbell/GCCalendar/blob/master/LICENSE) file for more info.
