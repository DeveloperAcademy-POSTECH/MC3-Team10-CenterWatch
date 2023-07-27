//
//  MemberGroupViewModel.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/14.
//

import Firebase
import FirebaseFirestore
import Foundation

/*
 MemberGroupViewModel: 서버(Firestore)와 뷰가 MemberGroup 정보를 주고 받도록 연결
 */

class MemberGroupViewModel: ObservableObject {
    let database = Firestore.firestore()
    @Published var memberGroups: [MemberGroup] = []
}



extension MemberGroupViewModel {
    
    // MARK: - Group Fetching (Method)
    /// Firestore에서 Group 문서를 가져옵니다.
    /// 사용법: 뷰가 나타나는 시점에 이 함수를 호출하여 서버에서부터 데이터를 받아옵니다.
    @MainActor
    func fetchMemberGroups() async -> QuerySnapshot? {
        do {
            let querySnapshot = try await database.collection("MemberGroup")
                .getDocuments()

            for document in querySnapshot.documents {
                let documentData = document.data()
                let id: String = documentData["id"] as? String ?? ""
                let memberGroup: MemberGroup = MemberGroup(id: id)

                self.memberGroups.append(memberGroup)
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    
    // MARK: - Create Group (Method)
    /// Firestore에 새로운 Group의 문서를 생성합니다.
    /// 사용법: 그룹 생성 뷰에서 초대 코드를 생성함과 동시에 이 함수를 호출해 서버에도 새 그룹을 만들어줍니다.
    func createMemberGroup(memberGroup: MemberGroup) async {
        do {
            try await database.collection("MemberGroup")
                .document(memberGroup.id)
                .setData(memberGroup.documentData())
        } catch {
            print(error)
        }
    }

    
    // updateGroup, removeGroup 메서드 추가 예정
}
