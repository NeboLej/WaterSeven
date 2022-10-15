//
//  ContentView.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            WSTodayWaterView()
                .frame(height: size.height / 2.5)
        }.background(Color("background"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
