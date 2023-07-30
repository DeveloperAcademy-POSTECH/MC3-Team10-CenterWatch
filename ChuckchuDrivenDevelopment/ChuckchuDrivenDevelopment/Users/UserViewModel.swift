//
//  UserViewModel.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/31.
//

import Firebase
import FirebaseFirestore
import Foundation


class UserViewModel: ObservableObject {
    let database = Firestore.firestore()
    @Published var users: [User] = []
}


extension UserViewModel {
    // MARK: - User Fetching (Method)
    /// Firestore에서 유저 문서를 가져옵니다.
    @MainActor
    func fetchUsers() async -> QuerySnapshot? {
        do {
            let querySnapshot = try await database.collection("Users")
                .getDocuments()

            for document in querySnapshot.documents {
                let documentData = document.data()
                let id: String = documentData["id"] as? String ?? ""
                let deviceToken: String = documentData["deviceToken"] as? String ?? ""
                let user: User = User(id: id, deviceToken: deviceToken)

                self.users.append(user)
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    
    // MARK: - Create User (Method)
    /// Firestore에 새로운 유저의 문서를 생성합니다.
    func createUser(user: User) async {
        do {
            try await database.collection("Users")
                .document(user.id)
                .setData(user.documentData())
        } catch {
            print(error)
        }
    }

}
