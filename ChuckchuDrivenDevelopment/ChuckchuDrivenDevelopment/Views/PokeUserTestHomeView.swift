//
//  PokeUserTestHomeView.swift
//  CDDDD
//
//  Created by alex on 2023/07/18.
//

import SwiftUI

struct PokeUserTestHomeView: View {
    @State private var showNotiSettingModal : Bool = false
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                Image("turtle")
                
                Spacer()
                Spacer()
                Spacer()
                NavigationLink(destination: PokeUserTestListView()){
                    Text("찌르기")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 96, maxHeight: 60)
                        .padding(EdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26))
                        .buttonStyle(.borderedProminent)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                }
                .padding(.bottom, 8)
                
                
                Button {
                    
                } label: {
                    Text("알림 설정")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 96, maxHeight: 60)
                        .padding(EdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26))
                        .buttonStyle(.borderedProminent)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                }
                
                
                
            }.navigationBarBackButtonHidden()
                .padding(.bottom, 72)
            
            
        } }
}

struct PokeUserTestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PokeUserTestHomeView()
    }
}
