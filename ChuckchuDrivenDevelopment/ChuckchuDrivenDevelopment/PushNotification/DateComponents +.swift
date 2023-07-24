//
//  DateComponents +.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/24.
//

import Foundation

/// Subscripting
extension DateComponents {
    /// Introduces date component subscripting
    /// This does not take into account any built-in errors
    /// Where Int.max returned instead of nil
    public subscript(component: Calendar.Component) -> Int? {
        switch component {
        case .era: return era
        case .year: return year
        case .month: return month
        case .day: return day
        case .hour: return hour
        case .minute: return minute
        case .second: return second
        case .weekday: return weekday
        case .weekdayOrdinal: return weekdayOrdinal
        case .quarter: return quarter
        case .weekOfMonth: return weekOfMonth
        case .weekOfYear: return weekOfYear
        case .yearForWeekOfYear: return yearForWeekOfYear
        case .nanosecond: return nanosecond
            // case .calendar: return self.calendar
        // case .timeZone: return self.timeZone
        default: return nil
        }
    }
}


/// Date and Component Utility
extension Date {
    /// Offset a date by n calendar components. Can be functionally chained
    /// For example:
    ///
    /// ```
    /// let afterThreeDays = date.offset(.day, 3)
    /// print(Date().offset(.day, 3).offset(.hour, 1).fullString)
    /// ```
    ///
    /// Not all components or offsets are useful
    public func offset(_ component: Calendar.Component, _ count: Int) -> Date {
        var newComponent: DateComponents = DateComponents(second: 0)
        switch component {
        case .era: newComponent = DateComponents(era: count)
        case .year: newComponent = DateComponents(year: count)
        case .month: newComponent = DateComponents(month: count)
        case .day: newComponent = DateComponents(day: count)
        case .hour: newComponent = DateComponents(hour: count)
        case .minute: newComponent = DateComponents(minute: count)
        case .second: newComponent = DateComponents(second: count)
        case .weekday: newComponent = DateComponents(weekday: count)
        case .weekdayOrdinal: newComponent = DateComponents(weekdayOrdinal: count)
        case .quarter: newComponent = DateComponents(quarter: count)
        case .weekOfMonth: newComponent = DateComponents(weekOfMonth: count)
        case .weekOfYear: newComponent = DateComponents(weekOfYear: count)
        case .yearForWeekOfYear: newComponent = DateComponents(yearForWeekOfYear: count)
        case .nanosecond: newComponent = DateComponents(nanosecond: count)
            // These items complete the component vocabulary but cannot be used in this way
            // case .calendar: newComponent = DateComponents(calendar: count)
        // case .timeZone: newComponent = DateComponents(timeZone: count)
        default: break
        }
        
        // If offset is not possible, return unmodified date
        return Date.sharedCalendar.date(byAdding: newComponent, to: self) ?? self
    }
}
