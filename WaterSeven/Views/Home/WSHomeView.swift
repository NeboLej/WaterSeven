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
//                .padding(.bottom, -160)
            ZStack(alignment: .center) {
                
                Rectangle()
                    .fill(Color("backgroundFirst"))
                    .frame(height: 100)
                WSCarouselView(cellsVM: $viewModel.plantsToday)
            }
            
            ForEach(viewModel.plants) { plant in
                WSPlantCell(vm: plant)
            }
            .padding(.horizontal, 10)
        }.background(Color("background"))
            .sheet(isPresented: $viewModel.isGoToSheet) {
                
            } content: {
                WSPlantView(viewModel: viewModel.routeSheet)
            }
    }
}

struct WSHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WSHomeView(viewModel: WSHomeViewModel())
    }
}
