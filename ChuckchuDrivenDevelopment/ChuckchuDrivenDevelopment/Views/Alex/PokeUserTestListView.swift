//
//  PokeUserTestListView.swift
//  CDDDD
//
//  Created by alex on 2023/07/18.
//

import SwiftUI

struct PokeUserTestListView: View {
    
    var body: some View {
        
        NavigationView{
            
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                HStack {
                    Image("turtle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                  
                    Text("test12345")
                    Spacer()
   
          
                    Button {
                        
                    } label: {
                        Text("찌르기")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: 46, maxHeight: 48)
                            .padding(EdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26))
                            .buttonStyle(.borderedProminent)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                    }
                }
            }
            .navigationTitle("꿋꿋단")
        }
        
       
        .listStyle(PlainListStyle())
    }}

struct PokeUserTestListView_Previews: PreviewProvider {
    static var previews: some View {
        PokeUserTestListView()
    }
}
