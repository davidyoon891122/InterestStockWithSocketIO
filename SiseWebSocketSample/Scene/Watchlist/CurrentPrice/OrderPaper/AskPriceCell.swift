//
//  AskPriceCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/27.
//

import UIKit
import SnapKit

final class AskPriceCell: UICollectionViewCell {
    static let identifier = "AskPriceCell"
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .label
        label.text = "54,200"
        
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = .label
        label.text = "1.10%"
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            priceLabel,
            percentLabel
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
        
        percentLabel.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

private extension AskPriceCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
