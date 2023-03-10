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
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "2.43%"
        label.textColor = .red
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        
        return label
    }()
    
    private let separatorView = SeparatorView()
    

    
    private lazy var containerView: UIView = {
        let view = UIView()
       
        [
            nameLabel,
            priceLabel,
            rateArrowImageView,
            prevLabel,
            rateLabel,
            separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 16.0
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.width.greaterThanOrEqualTo(100.0)
        }
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalTo(rateArrowImageView.snp.leading).offset(-offset / 2)
        }
        
        rateArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.trailing.equalTo(prevLabel.snp.leading).offset(-offset)
            $0.width.height.equalTo(16.0)
        }
        
        rateArrowImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        prevLabel.snp.makeConstraints {
            $0.centerY.equalTo(rateArrowImageView)
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-offset)
            $0.width.equalTo(40.0)
        }
        
        rateLabel.snp.makeConstraints {
            $0.centerY.equalTo(prevLabel)
            $0.leading.equalTo(prevLabel.snp.trailing).offset(offset)
            $0.width.greaterThanOrEqualTo(60.0)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(offset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    func setupCell(stock: CurrentPriceModel) {
        nameLabel.text = stock.stockName
        priceLabel.text = "\(stock.currentPrice)"
        prevLabel.text = "\(stock.prevPriceRate)"
        rateLabel.text = "\(stock.percentChange)".percent
        configureViewByUpAndDown(isUp: stock.isUp)
        
        setupViews()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return layoutAttributes
    }
}

private extension CurrentPriceCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureViewByUpAndDown(isUp: Bool) {
        switch isUp {
        case true:
            priceLabel.textColor = UIColor(named: "UpColor")
            prevLabel.textColor = UIColor(named: "UpColor")
            rateLabel.textColor = UIColor(named: "UpColor")
            rateArrowImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            rateArrowImageView.tintColor = UIColor(named: "UpColor")
        case false:
            priceLabel.textColor = UIColor(named: "DownColor")
            prevLabel.textColor = UIColor(named: "DownColor")
            rateLabel.textColor = UIColor(named: "DownColor")
            rateArrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            rateArrowImageView.tintColor = UIColor(named: "DownColor")
        }
    }
}

extension String {
    var percent: String {
        self + " %"
    }
}
