//
//  Group.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/14.
//

import Foundation

// MARK: - 그룹 정보 (struct)
/// 생성된 그룹의 정보는 아래의 형태로 저장됩니다.
struct Group: Identifiable, Codable, Hashable {
    let id: String // 그룹의 고유 id 값
    
    
    func documentData() -> [String: Any] { // 서버에 정보를 전달하기 위한 틀
        return [id: id]
    }
}
