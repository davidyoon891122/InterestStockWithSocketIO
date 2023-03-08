//
//  SelectedButton.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/08.
//

import UIKit
import SnapKit

class SelectedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        isSelected = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isSelected = false
    }
}

private extension SelectedButton {
    func updateAppearance() {
        if isSelected {
            backgroundColor = .lightGray.withAlphaComponent(0.6)
        } else {
            backgroundColor = .lightGray
        }
    }
}
