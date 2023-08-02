//
//  WeekdayCalculator.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/29.
//

import Foundation


// MARK: - 현재 요일 계산 (Method)
public func getCurrentWeekday() -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    let weekdayIndex = calendar.component(.weekday, from: currentDate)
    return weekdayIndex
}

// MARK: - 현재와 가장 가까운 요일 계산 (Method)
// TODO: - 로직 수정
/// 지금 abs()로 선택할 요일의 기준을 잡고 있는데 여기서 만약 현재가 토요일이고 금요일/일요일 두 요일의 알림을 요청하려고 하면, 다음 날인 일요일을 선택해야 하는데 하루씩밖에 차이가 안나기 때문에 금요일이 임의로 선택되는 현상이 발생. background fetch를 통해 자정마다 알림이 요청되는 요일 값이 달라지긴 해서 크게 문제가 될 건 없어 보이지만 그래도 뭔가 찝찝한...
public func getNearestWeekday(from weekdays: [Int]) -> Int {
    let currentDate = Date()
    let calendar = Calendar.current
    let currentDay = calendar.component(.weekday, from: currentDate)
    
    var nearestDay = weekdays.first!
    var minDifference = abs(currentDay - nearestDay)
    
    let _ = print(weekdays.first!)
    for day in weekdays {
        let difference = abs(currentDay - day)
        if difference < minDifference {
            minDifference = difference
            nearestDay = day
        }
    }
    return nearestDay
}

