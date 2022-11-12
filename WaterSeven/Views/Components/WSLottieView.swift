//
//  WSLottieView.swift
//  WaterSeven
//
//  Created by Nebo on 12.11.2022.
//

import SwiftUI
import Lottie

struct WSLottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop

    private let animationView = LottieAnimationView()

    func makeUIView(context: UIViewRepresentableContext<WSLottieView>) -> UIView {
        let view = UIView(frame: .zero)
    
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WSLottieView>) {
        animationView.play()
    }
}
