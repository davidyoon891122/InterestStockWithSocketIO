//
//  MatchCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit
import SnapKit

final class MatchCell: UICollectionViewCell {
    static let identifier = "MatchCell"
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .label
        label.text = "62,800"
        
        return label
    }()
    
    private lazy var volumnLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .label
        label.text = "423"
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            priceLabel,
            volumnLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        volumnLabel.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        volumnLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

private extension MatchCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

