//
//  DataModels.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/08/11.
//
import Combine

struct SelectedDay: Equatable, Hashable {
    let day: String
    var selected: Bool
}

struct Setting {
    
    var selectedDays: [SelectedDay] = [
        .init(day: String(localized: "Sun"), selected: false),
        .init(day: String(localized: "Mon"), selected: true),
        .init(day: String(localized: "Thu"), selected: true),
        .init(day: String(localized: "Wed"), selected: true),
        .init(day: String(localized: "Thu"), selected: true),
        .init(day: String(localized: "Fri"), selected: true),
        .init(day: String(localized: "Sat"), selected: false)
    ]
    
    var selectedStartHour: Int = 0
    var selectedEndHour: Int = 0
    var selectedFrequency: NotiInterval = .hour
    
    var selectedDaysInt: [Int] {
        var daysConvertedToInt: [Int] = []
        for selectedDay in selectedDays {
            if selectedDay.selected {
                daysConvertedToInt.append((selectedDays.firstIndex(of: selectedDay) ?? 0) + 1)
            }
        }
        return daysConvertedToInt
    }
}

enum NotiInterval: Int {
    case hour = 60
    case twoHour = 120
    case threeHour = 180
}
