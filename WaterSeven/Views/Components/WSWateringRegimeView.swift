//
//  WSWateringRegimeView.swift
//  WaterSeven
//
//  Created by Nebo on 27.10.2022.
//

import SwiftUI

struct WSWateringRegimeView: View {
    
    @State private var isPeriod = true
    @State private var slider = 1.0
    @State private var weeks = 1

    private let row = GridItem(.fixed(30))
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("График полива")
                .font(.custom(WSFont.regular, size: 16))
                .foregroundColor(Color("background3"))
            Text("Выберите один из вариантов")
                .font(.custom(WSFont.italic, size: 14))
                .foregroundColor(Color("background3"))
            
            HStack {
                WSButtonTwo(action: {
                    withAnimation(.easeOut.speed(2)) {
                        if !isPeriod {
                            isPeriod.toggle()
                        }
                    }
                }, label: Text("Выбрать частоту"), isPressed: $isPeriod)
                WSButtonTwo(action: {
                    withAnimation(.easeOut.speed(2)) {
                        if isPeriod {
                            isPeriod.toggle()
                        }
                    }
                }, label: Text("Выбрать дни"), isPressed: .init(get: {!isPeriod}, set: { _ in }))
            }
            .padding(.top, 10)
            
            if isPeriod {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 10) {
                        Spacer()
                        Text("1 раз в")
                            .font(.custom(WSFont.light, size: 14))
                        Text("\(Int(slider))")
                            .font(.custom(WSFont.bold, size: 36))
                            .offset(x: 0, y: -6)
                        Text(toReadDay(day: Int(slider)))
                            .font(.custom(WSFont.light, size: 14))
                    }
                    .padding(.top, 15)
                    .foregroundColor(Color("background3"))
                    
                    
                    Slider(value: $slider, in: 1...30, step: 1)
                        .tint(Color("background3"))
                    
                }
            } else {
                WSRegimeView(isEdit: true)
            }
        }
    }
    
    private func toReadDay(day: Int) -> String {
        if day == 1 {return "день"}
        if day > 1 && day < 5 { return "дня"}
        return "дней"
    }
}

struct WSWateringRegimeView_Previews: PreviewProvider {
    static var previews: some View {
        WSWateringRegimeView()
            .preferredColorScheme(.dark)
    }
}
