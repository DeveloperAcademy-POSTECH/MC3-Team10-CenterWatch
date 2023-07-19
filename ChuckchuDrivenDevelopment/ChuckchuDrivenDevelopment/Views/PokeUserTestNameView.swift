//
//  PokeUserTestNameView.swift
//  CDDDD
//
//  Created by alex on 2023/07/18.
//

import SwiftUI

struct PokeUserTestNameView: View {
    
    @State var name: String = ""
    
    var body: some View {
        
       NavigationView {
            VStack {
                Image("turtle")
                
                TextField("닉네임을 입력해주세요.", text: $name)
                           .font(Font.system(size: 16))
                           .padding()
                           .background(RoundedRectangle(cornerRadius: 10).fill(Color(uiColor: .systemGray6)))
                           .padding()
                           .foregroundColor(.white)
                
                    
                
                NavigationLink(destination: PokeUserTestHomeView()){
                    Text("완료")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 96, maxHeight: 60)
                        .padding(EdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26))
                        .buttonStyle(.borderedProminent)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                }
                
                
            }
            .padding()
            .toolbar(.hidden, for: .navigationBar)
           
        }
        
        
    }
    
}

struct PokeUserTestNameView_Previews: PreviewProvider {
    static var previews: some View {
        PokeUserTestNameView()
    }
}
