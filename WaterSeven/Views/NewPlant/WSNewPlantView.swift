//
//  WSNewPlantView.swift
//  WaterSeven
//
//  Created by Nebo on 21.10.2022.
//

import SwiftUI
import PhotosUI

struct WSNewPlantView: View {
    
    private let viewModel = WSNewPlantViewModel()
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType!
    @State private var isConformShow = false
    @State private var isAllertShow = false
    @State private var isImagePickerShow = false
    @State private var name = ""
    @State private var comment = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    isAllertShow = true
                } label: {
                    Text("Отмена")
                        .foregroundColor(Color("background3"))
                }
                Spacer()
                
                Text("Новое растение")
                    .foregroundColor(Color("background3"))
                Spacer()
                Button {
                    
                } label: {
                    Text("Сохранить")
                        .foregroundColor(Color("background3"))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .padding(.horizontal, 5)
            .background(Color("backgroundFirst"))
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 300, height: 300)
                    } else {
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 150)
                                .foregroundColor(Color("info"))
                                .padding(.top, 50)
                            Text("+ Добавить изображение")
                                .foregroundColor(Color("info"))
                                .font(.custom(WSFont.light, size: 16))
                                .padding(.vertical, 30)
                        }.frame(maxWidth: .infinity)
                            .background(Color.white)
                            .onTapGesture {
                                isConformShow = true
                            }
                    }
                    
                    ZStack {
                        WSLeafView(direction: .right)
                        VStack(spacing: 20) {
                            WSTextField(placeholder: "Название*", text: $name)
                                .padding(.top, 20)
                            WSTextField(placeholder: "Комментарий", text: $comment)
                                .padding(.bottom, 20)
                        }
                        .padding()
                    }
                    .padding(.bottom, 20)
                    
                    ZStack {
                        WSLeafView(direction: .left)
                        VStack {
                            WSWateringRegimeView()
                                .padding()
                        }
                        .padding()
                    }
                   

                }
                .interactiveDismissDisabled()
                .confirmationDialog("Что использовать?", isPresented: $isConformShow, titleVisibility: .visible) {
                    Button() {
                        sourceType = .camera
                        isImagePickerShow.toggle()
                    } label: {
                        Text("Камера")
                    }
                    Button() {
                        sourceType = .photoLibrary
                        isImagePickerShow.toggle()
                    } label: {
                        Text("Галерея")
                    }
                    Button() {
                        
                    } label: {
                        Text("Готовое изображеине")
                    }
                    
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("отмена")
                    }
                }
                .sheet(isPresented: $isImagePickerShow) {
                    WSImagePickerView(selectedImage: $selectedImage, sourceType: sourceType) }
                .alert("Изменения не сохранятся", isPresented: $isAllertShow) {
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("Отмена")
                    }
                    
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Text("Не сохранять")
                    }
                }
            }
        }.background(Color("background"))
    }
}

struct WSNewPlantView_Previews: PreviewProvider {
    static var previews: some View {
        WSNewPlantView()
    }
}
