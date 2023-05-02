//
//  Extension+UIView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit

extension UIView {
    func performScaleSmallerAnimation(targetView: UIView, completion: ((Bool)-> Void)?) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.4,
            options: .curveEaseInOut,
            animations: {
                targetView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0.3,
                    usingSpringWithDamping: 0.4,
                    initialSpringVelocity: 0.4,
                    options: .curveEaseInOut,
                    animations: {
                        targetView.transform = .identity
                    },
                    completion: completion
                )
            }
        )
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
extension UIView {
    struct UIViewPreview<View: UIView>: UIViewRepresentable {
        let view: View
        
        init(_ builder: @escaping () -> View) {
            view = builder()
        }
        
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ view: UIView, context: Context) {
            view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
    }
}


#endif
