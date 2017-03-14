![banner](Screenshots/Banner.png)

[![Release](https://img.shields.io/github/release/graycampbell/GCCalendar.svg)](https://github.com/graycampbell/GCCalendar/releases/latest)
[![CocoaPods](https://img.shields.io/cocoapods/v/GCCalendar.svg)](https://cocoapods.org/pods/GCCalendar)
[![Documentation](https://img.shields.io/cocoapods/metrics/doc-percent/GCCalendar.svg)](http://cocoadocs.org/docsets/GCCalendar)
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

### Documentation

- [Classes](http://cocoadocs.org/docsets/GCCalendar/2.0.1/Classes.html)
  - [GCCalendarView](http://cocoadocs.org/docsets/GCCalendar/2.0.1/Classes/GCCalendarView.html)

- [Enums](http://cocoadocs.org/docsets/GCCalendar/2.0.1/Enums.html)
  - [GCCalendarDisplayMode](http://cocoadocs.org/docsets/GCCalendar/2.0.1/Enums/GCCalendarDisplayMode.html)

- [Protocols](http://cocoadocs.org/docsets/GCCalendar/2.0.1/Protocols.html)
  - [GCCalendarViewDelegate](http://cocoadocs.org/docsets/GCCalendar/2.0.1/Protocols/GCCalendarViewDelegate.html)
  
### License

GCCalendar is available under the MIT license. See the LICENSE file for more info.
