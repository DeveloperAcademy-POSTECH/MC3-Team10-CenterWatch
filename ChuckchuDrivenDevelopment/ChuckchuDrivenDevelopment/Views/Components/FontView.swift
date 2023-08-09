//
//  FontView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/08/03.
//

import SwiftUI

struct FontView: View {
    let text: String
    let fontSize: CGFloat
    let textColor: Color
    let opacityValue: Float
    
    init(_ text : String,
         _ fontSize: CGFloat,
         _ textColor: Color,
         _ opacityValue: Float){
        self.text = text
        self.fontSize = fontSize
        self.textColor = textColor
        self.opacityValue = opacityValue
        
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom("Pretendard-Bold", size: fontSize))
            .foregroundColor(textColor)
            .opacity(Double(opacityValue))
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView("꿋꿋!", 20, .white, 1)
            .preferredColorScheme(.dark)
    }
}
