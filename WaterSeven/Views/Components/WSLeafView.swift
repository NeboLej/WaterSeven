//
//  WSLeafView.swift
//  WaterSeven
//
//  Created by Nebo on 27.10.2022.
//

import SwiftUI

struct WSLeafView: View {
    
    enum Direction {
        case left, right
    }
    
    let direction: Direction
    
    var body: some View {
        VStack {}
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(WSRoundedCornersShape(corners: direction == .right ? [.topLeft, .bottomRight] : [.bottomLeft, .topRight] , radius: 70).fill(Color("backgroundFirst")))
        .shadow(color: Color.black.opacity(0.27), radius: 2, x: 0, y: 4)
    }
}

struct WSLeafView_Previews: PreviewProvider {
    static var previews: some View {
        WSLeafView(direction: .right)
    }
}
