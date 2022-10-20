//
//  WSTabView.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import SwiftUI

struct WSTabView: View {
    
    @State var selectionTab = 1
    
    var body: some View {
        TabView(selection: $selectionTab) {
            WSAllPlantsView()
                .tabItem {
                Image(systemName: "list.bullet")
                Text("мои растения")
            }.tag(0)
            WSHomeView(viewModel: WSHomeViewModel())
                .tabItem {
                Image(systemName: "house")
                Text("главная")
            }.tag(1)
            WSSettingsView()
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
        WSTabView()
    }
}
