//
//  WSTextField.swift
//  WaterSeven
//
//  Created by Nebo on 26.10.2022.
//

import SwiftUI

struct WSTextField: View {
    @State private var isFocus = false
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            TextField("", text: $text) { (status) in
                if text.isEmpty {
                    withAnimation( status ? .easeIn : .easeOut) {
                        isFocus = status
                    }
                }
            } onCommit: {
                if text == "" {
                    withAnimation(.easeOut) {
                        isFocus = false
                    }
                }
            }
            .padding(.top, isFocus ? 15 : 0)
            .font(.custom(WSFont.bold, size: 18))
            .foregroundColor(Color("background3"))
            .background(
                Text(placeholder)
                    .scaleEffect(isFocus ? 0.8 : 1)
                    .offset(x: isFocus ? -7 : 0, y: isFocus ? -15 : 0)
                    .foregroundColor(Color("background3"))
                    .font(.custom(WSFont.light, size: 18))
                , alignment: .leading)
            
            .padding(.horizontal)
            
            Rectangle()
                .fill(isFocus ? Color.white : Color.gray)
                .opacity(isFocus ? 1 : 0.95)
                .frame(height: 1)
                .offset(x: 0, y: -8)
                .padding(.horizontal, isFocus ? 8 : 10)
        }
    }
}

struct WSTextField_Previews: PreviewProvider {
    @State var text = ""
    static var previews: some View {
        WSTextField(placeholder: "ssfdfs", text: .init(get: {
            ""
        }, set: { string in
            
        }))
        .preferredColorScheme(.dark)
    }
}
