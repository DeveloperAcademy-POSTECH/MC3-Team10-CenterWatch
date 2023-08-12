//
//  FontView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/08/03.
//

import SwiftUI

enum FontFamily {
    case pretendardBold
    case pretendardMedium
}

struct FontView: View {
    let text: String
    let fontFamily: FontFamily
    let fontSize: CGFloat
    let textColor: Color
    let opacityValue: Float
    
    init(_ text : String,
         _ fontFamily: FontFamily,
         _ fontSize: CGFloat,
         _ textColor: Color,
         _ opacityValue: Float){
        self.text = text
        self.fontFamily = fontFamily
        self.fontSize = fontSize
        self.textColor = textColor
        self.opacityValue = opacityValue
        
    }
    
    func getFontFamily(with: FontFamily) -> String {
        switch with {
        case .pretendardBold:
            return "Pretendard-Bold"
        case .pretendardMedium:
            return "Pretendard-Medium"
        }
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(getFontFamily(with: fontFamily), size: fontSize))
            .foregroundColor(textColor)
            .opacity(Double(opacityValue))
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView("꿋꿋!", .pretendardBold, 20, .white, 1)
            .preferredColorScheme(.dark)
    }
}
