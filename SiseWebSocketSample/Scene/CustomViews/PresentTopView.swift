//
//  PresentTopView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PresentTopView: UIView {
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            closeButton,
            titleLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        
        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(offset)
            $0.width.equalTo(36.0)
            $0.height.equalTo(36.0)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(closeButton.snp.trailing).offset(offset)
            $0.centerY.equalTo(closeButton)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    var buttonTap: ControlEvent<Void> {
        closeButton.rx.tap
    }
    
    init(title: String, buttonImage: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        closeButton.setImage(UIImage(systemName: buttonImage), for: .normal)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PresentTopView {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(50.0)
        }
    }
}

