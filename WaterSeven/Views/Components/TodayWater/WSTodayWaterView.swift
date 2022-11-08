//
//  WSTodayWaterView.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

struct WSTodayWaterView: View {
    
    @State var wateringToday: [String]
    
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
                    if wateringToday.isEmpty {
                        Text("Сегодня нет растений, требующих полива")
                            .font(.custom(WSFont.medium, size: 13))
                            .foregroundColor(Color("background3"))
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(wateringToday, id: \.self) { name in
                                    WSTodayWaterListView(text: name)
                                }
                            }
                        }
                        .padding(.vertical)
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
        HStack(alignment: .top) {
            Circle()
                .frame(width: 7, height: 7)
                .foregroundColor(Color("backgroundTwo"))
                .padding(.top, 5)
            Text(text)
                .font(.custom(WSFont.medium, size: 13))
                .foregroundColor(Color("background3"))
        }
    }
}

struct WSTodayWaterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WSTodayWaterView(wateringToday: [])
        }
    }
}
