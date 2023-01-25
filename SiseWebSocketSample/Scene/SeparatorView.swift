//
//  SeparatorView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import UIKit
import SnapKit

enum SeparatorDirection {
    case horizontal
    case vertical
}

final class SeparatorView: UIView {
    private lazy var separatorView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let size: CGFloat
    let direction: SeparatorDirection
    
    init(size: CGFloat = 1.0 , bgColor: UIColor = .lightGray.withAlphaComponent(0.5), direction: SeparatorDirection = .horizontal) {
        self.size = size
        self.direction = direction
        super.init(frame: .zero)
        separatorView.backgroundColor = bgColor
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SeparatorView {
    func setupViews() {
        addSubview(separatorView)
        switch direction {
        case .horizontal:
            separatorView.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.height.equalTo(size)
            }
        case .vertical:
            separatorView.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalTo(size)
            }
        }
    }
}
