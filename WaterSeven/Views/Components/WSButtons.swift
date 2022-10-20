//
//  WSButtons.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import SwiftUI


struct WSButtonOne: View {
    
    @State var action: () -> Void
    @State var label: Text
    @State var textColor = Color("backgroundFirst")
    @State var buttonColor = Color("background3")
    
    var body: some View {
        Button {
           action()
        } label: {
           label
                .font(.custom(WSFront.medium, size: 14))
                .foregroundColor(textColor)
        }
        .padding([.leading, .trailing], 18)
        .padding([.top, .bottom], 9)
        .background(buttonColor)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.25), radius: 1, x: 0, y: 2)
    }
    
    func setColor(text: Color, button: Color) {
        textColor = text
        buttonColor = button
    }
}

struct WSButtons_Previews: PreviewProvider {
    static var previews: some View {
        WSButtonOne(action: {}, label: Text("asdasd") )
//            .preferredColorScheme(.dark)
    }
}
