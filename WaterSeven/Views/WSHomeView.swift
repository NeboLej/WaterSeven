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
        }.background(Color("background"))
    }
}

struct WSHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WSHomeView(viewModel: WSHomeViewModel(serviceFactory: WSServiceFactoryMock()))
    }
}
