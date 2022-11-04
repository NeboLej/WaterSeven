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
        ScrollView {
            WSTodayWaterView()
                .frame(height: size.height / 2.5)
                .padding(.bottom, 23)
            WSCarouselView(cellsVM: $viewModel.plantsToday)
            ForEach(viewModel.plants) { plant in
                WSPlantCell(vm: plant)
            }
            .padding(.horizontal, 11)
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
