//
//  Scroll.swift
//  WaterSeven
//
//  Created by Nebo on 09.12.2022.
//

import SwiftUI

struct Scroll: View {
    
    var safeArea: EdgeInsets
    var size: CGSize
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ArtWork()
                
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
                    
                    Button {
                        
                    } label: {
                        Text("PLAY")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 45)
                            .padding(.vertical, 12)
                            .background {
                                Capsule()
                                    .fill(Color.red)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: minY < 50 ? -(minY - 50) : 0)
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)
                
                VStack {
                    Text("Popular")
                    
                    AlbumView()
                }
                .padding(.top, 10)
                .zIndex(0)
            }
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func ArtWork() -> some View {
        let height = size.height * 0.45
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height*0.8)
            
            Image("plant2")
                .resizable()
                .aspectRatio(contentMode: .fill)
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
        .frame(height: height+safeArea.top)
    }
    
    @ViewBuilder
    func AlbumView() -> some View {
        VStack(spacing: 25) {
            ForEach(albums.indices, id: \.self) { index in
                HStack(spacing: 25) {
                    Text("\(index + 1)")
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(albums[index].name)
                        Text("3434 6456 34")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(15)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Text("FHFHFHF")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                }
            }
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .offset(y: -minY)
        }
        .frame(height: 35)
    }
}

struct EPContentView: View {
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            Scroll(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
        .preferredColorScheme(.dark)
    }
}

struct Scroll_Previews: PreviewProvider {
    static var previews: some View {
        EPContentView()
    }
}


//test

struct Album: Identifiable {
    var id = UUID().uuidString
    var name: String
}

var albums: [Album]  =
[
    Album(name: "Gthdsasd"),
    Album(name: "afsa f"),
    Album(name: "Gthdasd asd asasd"),
    Album(name: "Gthdasd dasasd"),
    Album(name: "dfg d"),
    Album(name: "fdgfgj h"),
    Album(name: "cx sad e"),
    Album(name: "asd "),
    Album(name: "ertyuuyh ")
]
