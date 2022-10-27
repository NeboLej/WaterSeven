//
//  WSCalendarCell.swift
//  WaterSeven
//
//  Created by Nebo on 28.10.2022.
//

import SwiftUI

struct WSCalendarCell: View {
    
    @State var isActive = false
    let index: Int
    let click: (Int) -> Void
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color("background3"))
                .frame(width: 24, height: 24)
                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 3)
                .onTapGesture {
                    isActive.toggle()
                    click(index)
                }
            
            if isActive {
                Circle()
                    .frame(width: 7, height: 7)
                    .foregroundColor(Color("backgroundFirst"))
            }
        }
    }
}

struct WSCalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        WSCalendarCell(index: 1) { index in
            print(index)
        }
    }
}
