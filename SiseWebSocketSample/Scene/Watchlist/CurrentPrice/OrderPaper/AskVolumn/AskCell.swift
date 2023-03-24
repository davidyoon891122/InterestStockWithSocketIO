//
//  AskCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit
import SnapKit

final class AskCell: UICollectionViewCell {
    static let identifier = "AskCell"
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "89,000"
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .label
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            priceLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

private extension AskCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}
