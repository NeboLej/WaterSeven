//
//  WSRegimeView.swift
//  WaterSeven
//
//  Created by Nebo on 02.11.2022.
//

import SwiftUI

struct WSRegimeView: View {
    
    private let row = GridItem(.fixed(20))
    let isEdit: Bool
    @State var weeks = 4
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let calendar = ["пн", "вт", "ср", "чт", "пт", "сб", "вс"]
            HStack {
                LazyHGrid(rows: [row], alignment: .center, spacing: 25) {
                    ForEach(0..<7) { index in
                        Text(calendar[index])
                            .foregroundColor(Color("background3"))
                    }
                }
                Spacer()
            }.frame(height: 40)
             .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<weeks, id: \.self) { line in
                    LazyHGrid(rows: [row], alignment: .center, spacing: 20) {
                        ForEach(1..<8) { index in
                            WSCalendarCell(index: index + 7 * line) { index in
                                print(index)
                            }
                        }
                    }.frame(height: 40)
                }
            }

            if isEdit {
                HStack {
                    if weeks < 4 {
                        Button {
                            withAnimation(.easeInOut) {
                                weeks += 1
                            }
                        } label: {
                            Image(systemName: "plus")
                            Text("Добавить неделю")
                                .font(.custom(WSFont.light, size: 12))
                        }.foregroundColor(Color("background3"))
                    }

                    if weeks > 1 {
                        Button {
                            withAnimation(.easeInOut) {
                                weeks -= 1
                            }
                        } label: {
                            Image(systemName: "minus")
                            Text("Убрать неделю")
                                .font(.custom(WSFont.light, size: 12))
                        }.foregroundColor(Color("background3"))
                    }
                }
                .padding(.top, 10)
            }
        }.frame(maxWidth: .infinity)
    }
}

struct WSRegimeView_Previews: PreviewProvider {
    static var previews: some View {
        WSRegimeView(isEdit: false)
    }
}
