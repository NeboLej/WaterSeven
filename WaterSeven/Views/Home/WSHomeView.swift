//
//  WSHomeView.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

struct WSHomeView: View {
    
    @ObservedObject var viewModel: WSHomeViewModel
    @State var isSheet = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            WSTodayWaterView(wateringToday: viewModel.plantsToday.map{ $0.name })
                .frame(height: screenSize.height / 2.5)
            
            if !viewModel.plantsToday.isEmpty {
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(Color("backgroundFirst"))
                        .frame(height: 100)
                    WSCarouselView(cellsVM: $viewModel.plantsToday)
                }
            }
            
            if !viewModel.plants.isEmpty {
                VStack(alignment: .leading) {
                    Text("В ближайшие дни")
                        .font(.custom(WSFont.medium, size: 20))
                        .foregroundColor(Color("backgroundFirst"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color("backgroundFirst"))
                        .frame(width: screenSize.width/1.4 ,height: 3)
                    ForEach(viewModel.plants) { plant in
                        WSPlantCell(vm: plant)
                    }
                    .padding(.horizontal, 10)
                }
            } else {
                emptyPlant
            }
            
        }.background(Color("background"))
            .sheet(isPresented: $viewModel.isGoToSheet) {
                
            } content: {
                WSPlantView(viewModel: viewModel.routeSheet)
            }
    }
}

@ViewBuilder
var emptyPlant: some View {
    VStack(spacing: 0) {
        Text("В ближайшие дни нет растений, требующих полива")
            .font(.custom(WSFont.medium, size: 13))
            .foregroundColor(Color("background3"))
    }
    .background(Color("backgroundFirst"))
    .cornerRadius(20)
}

struct WSHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WSHomeView(viewModel: WSHomeViewModel())
    }
}
