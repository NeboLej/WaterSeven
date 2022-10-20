//
//  WSPlantCellView.swift
//  WaterSeven
//
//  Created by Nebo on 19.10.2022.
//

import SwiftUI

struct WSPlantCellView: View {
    
    @State var viewModel = WSPlantVM(name: "Кактус", image: "plant1", comment: "asdadas da d")
    
    var body: some View {
        HStack {
            Image(viewModel.image)
                .resizable()
                .scaledToFit()
                
            VStack( alignment: .leading ) {
                Text(viewModel.name)
                    .foregroundColor(.white)
                    .font(.custom(WSFront.medium, size: 20))
                Text(viewModel.comment)
                    .foregroundColor(.white)
                    .font(.custom(WSFront.medium, size: 10))
                Spacer()
                HStack {
                    Text("Полить: ")
                        .foregroundColor(.white)
                        .font(.custom(WSFront.medium, size: 14))
                    Text("день")
                        .foregroundColor(.white)
                        .font(.custom(WSFront.medium, size: 14))
                }
            }
            .padding([.top, .bottom], 12)
            Spacer()
            WSButtonOne(action: {
                viewModel.clickComplite()
            }, label: Text("Полил") )
            .padding(.trailing, 13)
        }
        .frame(height: 85)
        .background(WSRoundedCornersShape(corners: [.topRight, .bottomRight], radius: 27).fill(Color("backgroundFirst")))
    }
}

struct WSPlantCellView_Previews: PreviewProvider {
    static var previews: some View {
        WSPlantCellView(viewModel: WSPlantVM(name: "Кактус", image: "plant1", comment: "комментарий 1 ывфы "))
    }
}
