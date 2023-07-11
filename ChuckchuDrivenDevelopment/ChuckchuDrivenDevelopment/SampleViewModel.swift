//
//  SampleViewModel.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/11.
//

import Foundation
import Firebase
import FirebaseFirestore

class SampleViewModel: ObservableObject {
    let database = Firestore.firestore()
    @Published var samples: [Sample] = []
    
    
    // MARK: - Sample Fetching (Method)
    /// Firestore에서 Sample 문서를 가져옵니다.
    @MainActor
    func fetchSamples() async -> QuerySnapshot? {
        do {
            let querySnapshot = try await database.collection("Sample")
                .getDocuments()

            for document in querySnapshot.documents {
                let documentData = document.data()
                let id: String = documentData["id"] as? String ?? ""
                let name: String = documentData["name"] as? String ?? ""
                let text: String = documentData["text"] as? String ?? ""
                let sample: Sample = Sample(id: id, name: name, text: text)
                print(#function, sample)
                
                self.samples.append(sample)
            }
            
        } catch {
            print(error)
        }
        return nil
    }
    
    
}
