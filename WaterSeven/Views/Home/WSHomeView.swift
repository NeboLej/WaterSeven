//
//  WSHomeView.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

struct WSHomeView: View {
    
    let viewModel: WSHomeViewModel
    
    var body: some View {
        ScrollView {
            WSTodayWaterView()
                .frame(height: size.height / 2.5)
                .padding(.bottom, 23)
            ForEach(viewModel.plants) { plant in
                WSPlantCellView(viewModel: plant)
            }
            .padding(.horizontal, 11)
        }.background(Color("background"))
    }
}

struct WSHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WSHomeView(viewModel: WSHomeViewModel(serviceFactory: WSServiceFactoryMock()))
    }
}
