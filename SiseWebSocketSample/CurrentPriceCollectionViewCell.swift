//
//  CurrentPriceCollectionViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import UIKit
import SnapKit

final class CurrentPriceCollectionViewCell: UICollectionViewCell {
    static let identifier = "CurrentPriceCollectionViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Samsung"
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "63,300"
        label.textColor = .red
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var rateArrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.tintColor = .red
        
        return imageView
    }()
    
    private lazy var prevLabel: UILabel = {
        let label = UILabel()
        label.text = "1,500"
        label.textColor = .red
        
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "2.43%"
        label.textColor = .red
        
        return label
    }()
    

    
    private lazy var containerView: UIView = {
        let view = UIView()
       
        [
            nameLabel,
            priceLabel,
            rateArrowImageView,
            prevLabel,
            rateLabel,
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 16.0
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.width.greaterThanOrEqualTo(100.0)
            $0.bottom.equalToSuperview()
        }
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(offset)
        }
        
        rateArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(offset / 2)
            $0.width.height.equalTo(16.0)
        }
        
        prevLabel.snp.makeConstraints {
            $0.centerY.equalTo(rateArrowImageView)
            $0.leading.equalTo(rateArrowImageView.snp.trailing).offset(offset)
        }
        
        rateLabel.snp.makeConstraints {
            $0.centerY.equalTo(prevLabel)
            $0.leading.equalTo(prevLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

private extension CurrentPriceCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
