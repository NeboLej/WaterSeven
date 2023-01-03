//
//  WSPlantView.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import SwiftUI


struct WSPlantView: View {
    @ObservedObject var viewModel: WSPlantViewModel
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            Content(viewModel: viewModel, safeArea: safeArea, size: size)
        }
    }
}

fileprivate struct Content: View {
    
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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                imagePickerView(selectedImage: $viewModel.image, isEdit: isEditing)
                label()
                VStack(alignment: .leading, spacing: 0) {
                    if isEditing {
                        editPlantView()
                    } else {
                        plantView()
                    }
                }
            }
            .overlay(alignment: .top) {
                header()
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(1), Color("backgroundFirst").opacity(0.6)]), startPoint: .top, endPoint: .bottom))
    }
    
    @ViewBuilder
    func label() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
            
            Text(viewModel.name.uppercased())
                .font(.custom(WSFont.bold, size: 30))
                .foregroundColor(Color("background3"))
                .padding(.horizontal, 10)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: minY < 0 ? -(minY-2) : 0)
        }
        .frame(height: 50)
        .padding(.top, -70)
    }
    
    @ViewBuilder
    func editPlantView() -> some View {
        VStack {
            WSTextField(placeholder: "Название", text: $name).padding(.top, 15)
            WSTextField(placeholder: "комментарий", text: $comment)
            
            WSWateringRegimeView().padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0.9), Color("backgroundFirst").opacity(0)]), startPoint: .top, endPoint: .bottom))
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
    }
    
    @ViewBuilder
    func imagePickerView(selectedImage: Binding<UIImage?>, isEdit: Bool) -> some View {
        let height = size.height * 0.45
        
        GeometryReader{ proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height*0.9)
            
            WSImageView(selectedImage: selectedImage, isEdit: isEdit)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 1))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        //GRADIENT OVERLAY
                        Rectangle()
                            .fill(
                                .linearGradient(colors: [
                                    .black.opacity(0 - progress),
                                    .black.opacity(0.1 - progress),
                                    .black.opacity(0.3 - progress),
                                    .black.opacity(0.5 - progress),
                                    .black.opacity(0.8 - progress),
                                    .black.opacity(1)
                                ], startPoint: .top, endPoint: .bottom)
                            )
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func header() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY - 57
            
            HStack(spacing: 15) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Text(minY < -270 ? viewModel.name : "")
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
                        .font(.custom(WSFont.medium, size: 14))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                        .foregroundColor(Color("background3"))
                }
            }
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 10)
//            .background( minY < -270 ? .black : .clear)
            .background(LinearGradient(colors: [.black.opacity(minY < -270 ? 1 : 0.8),
                                                .black.opacity(minY < -270 ? 1 : 0.5),
                                                .black.opacity(minY < -270 ? 1 : 0)],
                                       startPoint: .top, endPoint: .bottom))
            .offset(y: -minY)
        }
        .frame(height: 35)
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
        WSPlantView(viewModel: WSPlantViewModel(plant: WSPlant(name: "Одуванчик полевой")))
    }
}
