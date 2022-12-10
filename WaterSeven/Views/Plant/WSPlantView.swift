//
//  WSPlantView.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import SwiftUI

struct WSPlantView1: View {
    
    @ObservedObject var viewModel: WSPlantViewModel
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            EPContentView1(viewModel: viewModel, safeArea: safeArea, size: size)
        }
    }
}


fileprivate struct EPContentView1: View {
    @Environment(\.dismiss) private var dismiss
    @State var isEditing = false
    
    @State var comment = ""
    @State var name = ""
    @State private var imageSize = CGSize()
    @State var weeks = 2
    
    private let row = GridItem(.fixed(30))
    
    @ObservedObject var viewModel: WSPlantViewModel
    var safeArea: EdgeInsets
    var size: CGSize
    
    init(viewModel: WSPlantViewModel, safeArea: EdgeInsets, size: CGSize) {
        self.viewModel = viewModel
        self.safeArea = safeArea
        self.size = size
        comment = viewModel.comment
        name = viewModel.name
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            header()
            imageView()
            
            if isEditing {
                editView()
            } else {
                plantView()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func imageView() -> some View {
        var height = size.height * 0.45
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height*0.8)
    
            WSImageView(selectedImage: $viewModel.image, isEdit: isEditing)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 1))
                .clipped()
//                .overlay(content: {
//                    ZStack(alignment: .bottom) {
//                        //GRADIENT OVERLAY
//                        Rectangle()
//                            .fill(
//                                .linearGradient(colors: [
//                                    .black.opacity(0 - progress),
//                                    .black.opacity(0.1 - progress),
//                                    .black.opacity(0.3 - progress),
//                                    .black.opacity(0.5 - progress),
//                                    .black.opacity(0.8 - progress),
//                                    .black.opacity(1)
//                                ], startPoint: .top, endPoint: .bottom)
//                            )
//                    }
//                })
                .offset(y: -minY)
        }
        .frame(height: height+safeArea.top)
    }
    
    
    @ViewBuilder
    func editView() -> some View {
        VStack {
            WSTextField(placeholder: "Название", text: $name).padding(.top, 15)
            WSTextField(placeholder: "комментарий", text: $comment)
            
            WSWateringRegimeView().padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0.9), Color("backgroundFirst").opacity(0)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(30)
        .background {
            Image(uiImage: viewModel.image ?? UIImage(named: "defaultImage")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(1)
                .blur(radius: 50)
                .colorMultiply(Color("backgroundFirst").opacity(0.5))
        }
    }
    
    @ViewBuilder
    func plantView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.comment).foregroundColor(Color("background3"))
                .font(.custom(WSFont.light, size: 16))
                .padding(.top, 15)
            Rectangle().foregroundColor(Color("background3"))
                .frame(height: 2)
                .padding(.top, 8)
            
            Text("Следующий полив: \(viewModel.nextWaterung())").foregroundColor(Color("background3"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical, 15)
            
            WSCalendarView(vm: viewModel.calendarVM)
                .background {
                    Image(uiImage: viewModel.image ?? UIImage(named: "defaultImage")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(1.5)
                        .blur(radius: 30)
                        .colorMultiply(Color("backgroundFirst").opacity(0.5))
                }
            
            HStack(alignment: .bottom, spacing: 10) {
                Text("График полива:")
                    .font(.custom(WSFont.regular, size: 16))
                Text("1 раз в ")
                    .font(.custom(WSFont.regular, size: 16))
                Text("\(viewModel.period)")
                    .font(.custom(WSFont.bold, size: 36))
                    .offset(y: 9)
                Text(viewModel.toReadDay(day: viewModel.period))
                    .font(.custom(WSFont.regular, size: 16))
            }
            .foregroundColor(Color("background3"))
            .padding(.top, 20)
            
            WSRegimeView(isEdit: false)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0.9), Color("backgroundFirst").opacity(0)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(30)
    }
    
    
    @ViewBuilder
    func header()-> some View {
        var height = size.height * 0.45
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height*0.8)
            
            HStack(spacing: 0) {
                Button {
                    //                isAllertShow = true
                } label: {
                    Text("Отмена")
                        .foregroundColor(Color("background3"))
                }
                Spacer()
                
                Text(viewModel.name)
                    .foregroundColor(Color("background3"))
                Spacer()
                
                Button {
                    if isEditing {
                        saveClick()
                    } else {
                        editClick()
                    }
                } label: {
                    Text(isEditing ? "Сохранить" : "Изменить")
                        .foregroundColor(Color("background3"))
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 5)
            .background(Color("backgroundFirst"))
            .offset(y: -minY)
            
        }
        .frame(height: height+safeArea.top)
        

    }
    
    private func editClick() {
        isEditing = true
        comment = viewModel.comment
        name = viewModel.name
    }
    
    private func saveClick() {
        isEditing = false
        viewModel.comment = comment
        viewModel.name = name
    }
}

















struct WSPlantView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var isEditing = false
    
    @State var comment = ""
    @State var name = ""
    @State private var imageSize = CGSize()
    @State var weeks = 2
    
    private let row = GridItem(.fixed(30))
    
    @ObservedObject var viewModel: WSPlantViewModel
    
    init(viewModel: WSPlantViewModel) {
        self.viewModel = viewModel
        comment = viewModel.comment
        name = viewModel.name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header()
            ZStack(alignment: .top) {
                WSImageView(selectedImage: $viewModel.image, isEdit: isEditing)
                    .readSize { size in imageSize = size }
                
                VStack(spacing: 0){
                    Spacer(minLength: imageSize.height/1.2)
                    ScrollView(.vertical, showsIndicators: false) {
                        if isEditing {
                            editView
                        } else {
                            plantView
                        }
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0), Color("backgroundFirst").opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                }
            }
        }
    }
    
    @ViewBuilder
    var editView: some View {
        VStack {
            WSTextField(placeholder: "Название", text: $name).padding(.top, 15)
            WSTextField(placeholder: "комментарий", text: $comment)
            
            WSWateringRegimeView().padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0.9), Color("backgroundFirst").opacity(0)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(30)
        .background {
            Image(uiImage: viewModel.image ?? UIImage(named: "defaultImage")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(1)
                .blur(radius: 50)
                .colorMultiply(Color("backgroundFirst").opacity(0.5))
        }
    }
    
    @ViewBuilder
    var plantView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.comment).foregroundColor(Color("background3"))
                .font(.custom(WSFont.light, size: 16))
                .padding(.top, 15)
            Rectangle().foregroundColor(Color("background3"))
                .frame(height: 2)
                .padding(.top, 8)
            
            Text("Следующий полив: \(viewModel.nextWaterung())").foregroundColor(Color("background3"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical, 15)
            
            WSCalendarView(vm: viewModel.calendarVM)
                .background {
                    Image(uiImage: viewModel.image ?? UIImage(named: "defaultImage")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(1.5)
                        .blur(radius: 30)
                        .colorMultiply(Color("backgroundFirst").opacity(0.5))
                }
            
            HStack(alignment: .bottom, spacing: 10) {
                Text("График полива:")
                    .font(.custom(WSFont.regular, size: 16))
                Text("1 раз в ")
                    .font(.custom(WSFont.regular, size: 16))
                Text("\(viewModel.period)")
                    .font(.custom(WSFont.bold, size: 36))
                    .offset(y: 9)
                Text(viewModel.toReadDay(day: viewModel.period))
                    .font(.custom(WSFont.regular, size: 16))
            }
            .foregroundColor(Color("background3"))
            .padding(.top, 20)
            
            WSRegimeView(isEdit: false)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0.9), Color("backgroundFirst").opacity(0)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(30)
    }
    
    @ViewBuilder
    func header()-> some View {
        HStack(spacing: 0) {
            Button {
                //                isAllertShow = true
            } label: {
                Text("Отмена")
                    .foregroundColor(Color("background3"))
            }
            Spacer()
            
            Text(viewModel.name)
                .foregroundColor(Color("background3"))
            Spacer()
            
            Button {
                if isEditing {
                    saveClick()
                } else {
                    editClick()
                }
            } label: {
                Text(isEditing ? "Сохранить" : "Изменить")
                    .foregroundColor(Color("background3"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .padding(.horizontal, 5)
        .background(Color("backgroundFirst"))
    }
    
    private func editClick() {
        isEditing = true
        comment = viewModel.comment
        name = viewModel.name
    }
    
    private func saveClick() {
        isEditing = false
        viewModel.comment = comment
        viewModel.name = name
    }
}

struct WSPlantView_Previews: PreviewProvider {
    static var previews: some View {
        WSPlantView1(viewModel: WSPlantViewModel(plant: WSPlant(name: "Олег", comment: "комментарий некоторой длинны", image: "plant1", period: 3, wateringSchedule: [])))
    }
}
