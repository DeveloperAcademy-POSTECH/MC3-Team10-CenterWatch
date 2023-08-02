//
//  Poke.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/14.
//
//
//import Foundation
//
//// MARK: - 찌르기 정보 (struct)
///// 찌르기를 하나의 액션으로 바라볼 때, 단일 액션의 정보는 아래의 형태로 저장됩니다.
//struct Poke: Identifiable, Codable, Hashable {
//    let id: String // 발생한 찌르기의 고유 id 값
//    let date: Date // 찌르기 액션이 생성된 시간
//    let fromID: String // 찌르기를 발송한 유저의 id 값
//    let fromUsername: String // 찌르기를 발송한 유저의 username 값
//    let toID: String // 찌르기를 수신한 유저의 id 값
//    let toUsername: String // 찌르기를 수신한 유저의 username 값
//    let reaction: String // 찌르기를 수신한 유저가 남긴 리액션 (emoji 형태)
//    
//    
//    func documentData() -> [String: Any] { // 서버에 정보를 전달하기 위한 틀
//        return [
//            "id": id,
//            "date": Date(),
//            "fromID": fromID,
//            "fromUsername": fromUsername,
//            "toID": toID,
//            "toUsername": toUsername,
//            "reaction": reaction
//        ]
//    }
//}
//
