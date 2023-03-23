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
