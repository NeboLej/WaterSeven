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
    //    @State private var selectedImage: UIImage?
    //    @State private var sourceType: UIImagePickerController.SourceType!
    //    @State private var isConformShow = false
    @State private var isAllertShow = false
    //    @State private var isImagePickerShow = false
    @State private var name = ""
    @State private var comment = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 0) {
            header
            ScrollView {
                VStack(spacing: 0) {
//                    WSImageView()
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
                    
                    WSButtonOne(action: {
                        dismiss()
                    }, label: Text("Сохранить").font(.custom(WSFont.regular, size: 18)), textColor: Color("background3"), buttonColor: Color("backgroundFirst"))
                    .padding()
                }
                .interactiveDismissDisabled()
                
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
    
    @ViewBuilder
    var header: some View {
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
                dismiss()
            } label: {
                Text("Сохранить")
                    .foregroundColor(Color("background3"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .padding(.horizontal, 5)
        .background(Color("backgroundFirst"))
    }
}

struct WSNewPlantView_Previews: PreviewProvider {
    static var previews: some View {
        WSNewPlantView()
    }
}
