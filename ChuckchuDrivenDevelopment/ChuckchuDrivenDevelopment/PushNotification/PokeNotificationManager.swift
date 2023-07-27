//
//  PokeNotificationManager.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/19.
//

import Foundation
import SwiftUI

class PokeNotificationManager: ObservableObject {
    private(set) var currentUserDeviceToken: String?

    
    // MARK: - setCurrentUserDeviceToken (Method)
    /// private(set) 속성에 접근하여 DeviceToken을 할당합니다.
    public func setCurrentUserDeviceToken(token: String) {
        currentUserDeviceToken = token
    }

    init(
           currentUserDeviceToken: String?
       ) {
           self.currentUserDeviceToken = currentUserDeviceToken
       }
    
  
    
    // MARK: - sendPokeNotification (Method)
    /// 앱이 빌드된 기기에서 -> 특정 기기 토큰(userDeviceToken)으로 찌르기 알림을 발송합니다.
    public func sendPokeNotification(toUserDeviceToken: String,
                                     currentMemberUsername: String) async -> Void {
        
        /// url == FCM Legacy HTTP의 엔드포인트
        let url = "https://fcm.googleapis.com/fcm/send"
        guard let url = URL(string: url) else {
            return
        }
        
        let messageTitle = "\(currentMemberUsername)님이 사용자님을 찔렀습니다👈"
        let messageBody = "꼼짝 마세요! 당신은 허리 경찰에게 포착되었습니다! 당장 허리를 펴주세요"
        
        /// HTTP Request의 body로 전달할 data를 딕셔너리로 선언한 후, JSON으로 변환
        let json: [String: Any] =
        [
            /// 특정 기기에 알람을 보내기 위해 "to"를 사용
            /// 경우에 따라 Topic 등 다른 용도로 활용 가능
            "to": toUserDeviceToken,
            
            /// 알림의 내용
            "notification": [
                "title": messageTitle,
                "body": messageBody
            ],
            
            
            /// 알림을 보내며 함께 전달할 데이터를 삽입
            "data": [
                "userName": "lianne"
            ]
        ]
        
        /// HTTP Body로 전달할 JSON 파일을 상단의 딕셔너리로 생성
        let httpBody = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        /// URLReqeust를 만들고 적절한 메소드와 헤더 설정
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /// 저장해둔 서버 키 사용
        request.setValue("key= ", forHTTPHeaderField: "Authorization")
        
        do {
            guard let httpBody else { return }
            
            /// 비동기 함수로 정의된 URLSession upload(for:from:) 메소드를 호출
            /// uploadPayload == (Data, Response)의 튜플 타입
            let uploadPayload = try await URLSession.shared.upload(for: request, from: httpBody)
            
            /// 송수신 데이터 확인
            dump("DEBUG: PUSH POST SUCCESSED - \(uploadPayload.0)")
        } catch {
            /// 실패했을 경우 에러 출력
            dump("DEBUG: PUSH POST FAILED - \(error)")
        }
        
    }
}


