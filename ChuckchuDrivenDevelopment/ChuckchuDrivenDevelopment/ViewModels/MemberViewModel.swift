//
//  MemberViewModel.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/14.
//

import Firebase
import FirebaseFirestore
import Foundation

/*
MemberViewModel: 서버(Firestore)와 뷰가 Member 정보를 주고 받도록 연결
*/

class MemberViewModel: ObservableObject {
    let database = Firestore.firestore()
    @Published var members: [Member] = []
}



extension MemberViewModel {
    
    // MARK: - Member Fetching (Method)
    /// Firestore에서 Member 문서를 가져옵니다.
    /// 사용법: 뷰가 나타나는 시점에 이 함수를 호출하여 서버에서부터 데이터를 받아옵니다.
    @MainActor
    func fetchMembers(groupID: String) async -> QuerySnapshot? {
        do {
            let querySnapshot = try await database.collection("MemberGroup")
                .document(groupID)
                .collection("Member")
                .getDocuments()

            for document in querySnapshot.documents {
                let documentData = document.data()
                let id: String = documentData["id"] as? String ?? ""
                let username: String = documentData["username"] as? String ?? ""
                let deviceToken: String = documentData["deviceToken"] as? String ?? ""
                let member: Member = Member(id: id, username: username, deviceToken: deviceToken)

                self.members.append(member)
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    
    // MARK: - Create Member (Method)
    /// Firestore에 새로운 Member의 문서를 생성합니다.
    /// 사용법: 회원가입 뷰에서 가입과 동시에 이 함수를 호출해 서버에 새 유저의 정보를 생성해줍니다.
    func createMember(groupID: String, with member: Member) async {
        do {
            try await database.collection("MemberGroup")
                .document(groupID)
                .collection("Member")
                .document(member.id)
                .setData(member.documentData())
        } catch {
            print(error)
        }
    }
    
    
    // updateMember, removeMember 메서드 추가 예정
}
