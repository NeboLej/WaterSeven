//
//  WSLottieView.swift
//  WaterSeven
//
//  Created by Nebo on 12.11.2022.
//

import SwiftUI
import Lottie

//struct WSLottieView: UIViewRepresentable {
//    var lottieFile: String
//    let animationView = AnimationView()
//
//    func makeUIView(context: Context) -> some UIView {
//        let view = UIView(frame: .zero)
//
//        animationView.animation = Animation.named(lottieFile)
//        animationView.contentMode = .scaleAspectFit
//        animationView.play()
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//}

struct WSLottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: UIViewRepresentableContext<WSLottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
