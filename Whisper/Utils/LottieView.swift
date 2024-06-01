//
//  LottieView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String
    let loopMode: LottieLoopMode

    func makeUIView(context: Context) -> some UIView {
            let view = UIView(frame: .zero)
            let animationView = LottieAnimationView(name: filename)
            animationView.contentMode = .scaleAspectFit
            animationView.play()
            animationView.loopMode = loopMode
            animationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(animationView)
            
            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
            
            return view
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {}

}
