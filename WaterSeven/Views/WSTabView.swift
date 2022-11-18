//
//  WSTabView.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import SwiftUI

struct WSTabView: View {
    
    @State private var selectionTab = 1
    @ObservedObject var viewModel: WSTabViewModel
    
    var body: some View {
        TabView(selection: $selectionTab) {
            WSAllPlantsView(viewModel: WSAllPlantsViewModel())
                .tabItem {
                Image(systemName: "list.bullet")
                Text("мои растения")
            }.tag(0)
            WSHomeView(viewModel: viewModel.getHomeViewModel())
                .tabItem {
                Image(systemName: "house")
                Text("главная")
            }.tag(1)
            WSSettingsView(viewModel: WSSettingsViewModel() )
                .tabItem {
                Image(systemName: "gearshape")
                Text("настройки")
            }.tag(2)
            
        }
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        }
        .accentColor(Color("backgroundFirst"))
        .font(.headline)
    }
}

struct WSTabView_Previews: PreviewProvider {
    static var previews: some View {
        WSTabView(viewModel: WSTabViewModel(servicesFactory: WSServicesFactory()))
    }
}
