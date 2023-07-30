//
//  SilentPushNotificationManager.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/30.


import Foundation
import SwiftUI

class SilentPushNotificationManager: ObservableObject {
    private(set) var currentUserDeviceToken: String?
 
    public func setCurrentUserDeviceToken(token: String) {
        currentUserDeviceToken = token
    }
    
    init(currentUserDeviceToken: String?) {
        self.currentUserDeviceToken = currentUserDeviceToken
    }
    
    // schedule set to next day, at 12:00AM
    public func sendNotificationOnDayChanged(userDeviceToken: String) async -> Void {
        let url = "https://fcm.googleapis.com/fcm/send"
        guard let url = URL(string: url) else {
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        
        // Get the date for the next day's midnight
        if let tomorrowMidnight = calendar.date(byAdding: .day, value: 1, to: calendar.date(from: dateComponents)!) {
            let midnightTimestamp = Int64(tomorrowMidnight.timeIntervalSince1970 * 1000)
            
            let json: [String: Any] = [
                "to": userDeviceToken,
                "content_available": true,
                "apns-priority": 5,
                "time_to_live": Int(tomorrowMidnight.timeIntervalSinceNow), // Set TTL to ensure the message is not delivered if it's too late
                "data": ["scheduled_time": midnightTimestamp]
            ]
            
            let httpBody = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("key=YOUR_FIREBASE_SERVER_KEY", forHTTPHeaderField: "Authorization")
            
            do {
                guard let httpBody = httpBody else { return }
                let uploadPayload = try await URLSession.shared.upload(for: request, from: httpBody)
                dump("DEBUG: PUSH POST SUCCESS - \(uploadPayload.0)")
            } catch {
                dump("DEBUG: PUSH POST FAILED - \(error)")
            }
        }
    }
    

}
