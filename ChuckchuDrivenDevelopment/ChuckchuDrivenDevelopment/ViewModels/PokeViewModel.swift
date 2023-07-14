//
//  PokeViewModel.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/14.
//

import Firebase
import FirebaseFirestore
import Foundation

/*
PokeViewModel: 서버(Firestore)와 뷰가 Poke 정보를 주고 받도록 연결
*/

class PokeViewModel: ObservableObject {
    let database = Firestore.firestore()
    @Published var pokes: [Poke] = []
}



extension PokeViewModel {
    
    // MARK: - Poke Fetching (Method)
    /// Firestore에서 Poke 문서를 가져옵니다.
    /// 사용법: 모든 찌르기 정보를 불러와야 하는 경우에 이 함수를 호출합니다.
    @MainActor
    func fetchPoke(groupID: String) async -> QuerySnapshot? {
        do {
            let querySnapshot = try await database.collection("Group")
                .document(groupID)
                .collection("Poke")
                .getDocuments()

            for document in querySnapshot.documents {
                let documentData = document.data()
                let id: String = documentData["id"] as? String ?? ""
                let date: Date = documentData["date"] as? Date ?? Date()
                let fromID: String = documentData["fromID"] as? String ?? ""
                let toID: String = documentData["toID"] as? String ?? ""
                let reaction: String = documentData["reaction"] as? String ?? ""
                let poke: Poke = Poke(id: id, date: date, fromID: fromID, toID: toID, reaction: reaction)

                self.pokes.append(poke)
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    
    // MARK: - Create Poke (Method)
    /// Firestore에 새로운 Poke의 문서를 생성합니다.
    /// 사용법: 찌르기를 누를 때 관련된 이 함수를 호출하여 찌르기를 서버에 기록하고, 관련된 정보를 저장해줍니다.
    func createPoke(groupID: String, with poke: Poke) async {
        do {
            try await database.collection("Group")
                .document(groupID)
                .collection("Poke")
                .document(poke.id)
                .setData(poke.documentData())
        } catch {
            print(error)
        }
    }
    
    

    // updatePoke, removePoke 메서드 추가 예정
}


