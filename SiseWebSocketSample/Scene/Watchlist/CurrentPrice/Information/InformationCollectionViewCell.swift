//
//  InformationCollectionViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/22.
//

import UIKit
import SnapKit

final class InformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "InformationCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Capitalization"
        label.textColor = .label
        
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "9,691"
        label.textColor = .label
        
        return label
    }()
    
    private let separatorView = SeparatorView(
        size: 1.0,
        bgColor: .lightGray.withAlphaComponent(0.5),
        direction: .horizontal
    )
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            titleLabel,
            contentLabel,
            separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
            $0.width.lessThanOrEqualTo(130.0)
        }
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        contentLabel.snp.makeConstraints {
            $0.top.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(offset * 3)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

private extension InformationCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

