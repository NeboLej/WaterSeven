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
                .font(.custom(WSFont.medium, size: 14))
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

struct WSButtonTwo: View {
    
    @State var action: () -> Void
    @State var label: Text
    @State var firstColor = Color("backgroundFirst")
    @State var secondColor = Color("background3")
    @Binding var isPressed: Bool
    
    var body: some View {
        Button {
           action()
        } label: {
           label
                .font(.custom(WSFont.medium, size: 14))
                .foregroundColor(!isPressed ? firstColor : secondColor)
        }
        .padding([.leading, .trailing], 18)
        .padding([.top, .bottom], 9)
        .background(!isPressed ? secondColor : firstColor)
        .cornerRadius(15)
        .shadow(color: !isPressed ? Color.black.opacity(0.25) : Color.clear , radius: 1, x: 0, y: 2)
        .overlay(content: {
            if isPressed {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("backgroundFirst"), lineWidth: 1)
                    .shadow(color: Color.black.opacity(0.7), radius: 1, x: 0, y: 2)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: -2)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        })
    }
    
    func setColor(firstColor: Color, secondColor: Color) {
        self.firstColor = firstColor
        self.secondColor = secondColor
    }
}


struct WSButtons_Previews: PreviewProvider {
    
    
    static var previews: some View {
//        WSButtonOne(action: {}, label: Text("asdasd") )
//            .previewLayout(.sizeThatFits)
        HStack {
            WSButtonTwo(action: {}, label: Text("Выбрать частоту"), isPressed: .init(get: {true}, set: { _ in }))
            WSButtonTwo(action: {}, label: Text("Выбрать дни"), isPressed: .init(get: {false}, set: { _ in }))
        }
        
    }
}
