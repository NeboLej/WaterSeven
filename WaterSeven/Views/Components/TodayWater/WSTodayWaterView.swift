//
//  WSTodayWaterView.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

let size = UIScreen.main.bounds

struct WSTodayWaterView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(Color("backgroundFirst").opacity(0.9))
            VStack(alignment: .leading, spacing: 0.0) {
                Text("Полей сегодня")
                    .foregroundColor(Color("textTitle1"))
                    .font(.custom("AvenirNext-Medium", size: 30))
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(Color("textTitle1"))
                        .frame(width: 20, height: 18)
                    Text("25 Октября")
                        .foregroundColor(Color("textTitle1"))
                        .font(.custom("AvenirNext-Light", size: 10))
                    
                }
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        WSTodayWaterListView(text: "Фикус Георгий")
                        WSTodayWaterListView(text: "Ромашка полевая")
                    }
                    Spacer()
                    Image("flower1")
                        .resizable()
                        .scaledToFit()
                        .padding(.trailing, -10)
                }
            }
            .padding([.top, .leading], 23 )
            
            
        }
        .padding(.horizontal, 11)
    }
}

struct WSTodayWaterListView: View {
    @State var text: String
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 7, height: 7)
                .foregroundColor(Color("backgroundTwo"))
            Text(text)
                .font(.custom("AvenirNext-Medium", size: 13))
                .foregroundColor(Color("textTitle1"))
        }
    }
}

struct WSTodayWaterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WSTodayWaterView()
                .previewDevice("iPhone SE (3rd generation)")
//            WSTodayWaterListView(text: "Фикус")
        }
    }
}
