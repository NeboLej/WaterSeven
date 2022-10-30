//
//  WSCalendarView.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import SwiftUI

struct WSCalendarView: View {
    
    @ObservedObject var vm: WSCalendarVM
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(vm.extraDate()[0])
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("calendarText"))
                        Text(vm.extraDate()[1])
                            .font(.title.bold())
                            .foregroundColor(Color("calendarText"))
                    }
                    Spacer(minLength: 0)
                    Button {
                        withAnimation {
                            vm.currentMonth -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("calendarText"))
                            .font(.title2)
                    }
                    
                    Button {
                        withAnimation {
                            vm.currentMonth += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("calendarText"))
                            .font(.title2)
                    }
                    
                }
                .padding(.horizontal)
                
                HStack(spacing: 0) {
                    ForEach(vm.days, id: \.self) { day in
                        Text(day)
                            .font(.custom(WSFont.bold, size: 18))
                            .foregroundColor(Color("calendarText"))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(vm.extractDate()) {
                        dateCell(model: $0)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func dateCell(model: WSDateModel) -> some View {
        ZStack {
            if model.day != -1 {
                Text("\(model.day)")
                    .font(.custom(WSFont.medium, size: 16))
                    .foregroundColor(model.date.isSameDay(date: vm.currentDate) ? Color("calendarTextCurrent") : Color("calendarText"))
                    .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: 32)
        .background (
            Circle()
                .strokeBorder(fillCell(date: model.date), lineWidth: 1)
        )
        .onTapGesture {
            vm.selectedDate = model.date
        }
    }
    
    private func fillCell(date: Date) -> Color {
        var color = Color.clear
        
        if date.isSameDay(date: vm.currentDate) {
            color = .red
        }
        
        if vm.wateringDays.first(where: { $0.isSameDay(date: date) }) != nil {
            color = Color("calendarMark")
        }
        
        if date.isSameDay(date: vm.selectedDate) {
            color = Color("calendarSelected")
        }
        return color
    }
}

struct WSCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WSPlantView()
    }
}


