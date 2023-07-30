//
//  Base64TestingView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/31.
//

import Foundation
import SwiftUI


struct Base64TestingView: View {
    @State private var originalText = "Hello, Base64!"
    @State private var base64String = ""
    @State private var decodedText = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Input")
                    .font(.caption2)
                TextField("Enter text", text: $originalText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            
            HStack {
                Button("Encode to Base64") {
                    if let data = originalText.data(using: .utf8) {
                        base64String = data.base64EncodedString()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Decode from Base64") {
                    if let data = Data(base64Encoded: base64String) {
                        if let decodedString = String(data: data, encoding: .utf8) {
                            decodedText = decodedString
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Base64 Encoded:")
                        .font(.caption2)
                    Text(base64String)
                        .padding(.vertical, 10)
                }
                
                HStack {
                    Text("Base64 Decoded: ")
                        .font(.caption2)
                    Text(decodedText)
                }
            }
            
        }
        .padding()
    }
}



struct Base64TestingView_Previews: PreviewProvider {
    static var previews: some View {
        Base64TestingView()
    }
}
