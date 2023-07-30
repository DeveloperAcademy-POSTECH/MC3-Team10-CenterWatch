//
//  User.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/31.
//

import Foundation


// MARK: - 유저 정보 (struct)
/// 앱을 최초 실행한 유저의 정보는 아래의 형태로 저장됩니다.
struct User: Identifiable, Codable, Hashable {
    let id: String // 유저의 고유 id 값
    let deviceToken: String // 유저의 기기 토큰 값 (암호화 처리)
    
    func documentData() -> [String: Any] { // 서버에 정보를 전달하기 위한 틀
        return [
            "id": id,
            "deviceToken": deviceToken
        ]
    }
}
