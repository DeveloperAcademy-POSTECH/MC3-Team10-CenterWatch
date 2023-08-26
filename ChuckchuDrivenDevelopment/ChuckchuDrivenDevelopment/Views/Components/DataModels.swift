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

class Setting: ObservableObject {
    
    @Published var selectedDays: [SelectedDay] = [
        .init(day: "일", selected: false),
        .init(day: "월", selected: true),
        .init(day: "화", selected: true),
        .init(day: "수", selected: true),
        .init(day: "목", selected: true),
        .init(day: "금", selected: true),
        .init(day: "토", selected: false)
    ]
    
    @Published var selectedStartHour: Int = 0
    @Published var selectedEndHour: Int = 0
    @Published var selectedFrequency: NotiInterval = .hour
    
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

struct SendToWatch {
    var selectedStartHour: Int = 0
    var selectedEndHour: Int = 0
    var selectedFrequency: NotiInterval = .hour
}
