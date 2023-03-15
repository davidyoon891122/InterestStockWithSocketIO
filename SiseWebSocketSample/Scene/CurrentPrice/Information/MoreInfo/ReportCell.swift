//
//  ReportCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/13.
//

import UIKit
import SnapKit

final class ReportCell: UICollectionViewCell {
    static let identifier = "ReportCell"
    
    private lazy var tickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "01:58∙Mar 15∙"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var providerLabel: UILabel = {
        let label = UILabel()
        label.text = "Reuters"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.text = "A Fed pause: Benficial to banks, but a bad sign for the economy"
        label.numberOfLines = 2
        
        return label
    }()
    
    private let separatorView = SeparatorView(size: 1.0, bgColor: .gray.withAlphaComponent(0.3), direction: .horizontal)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            tickerCollectionView,
            dateLabel,
            providerLabel,
            titleLabel,
            separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        
        let offset: CGFloat = 16.0
        tickerCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.width.equalTo(100.0)
            $0.height.equalTo(30.0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(tickerCollectionView)
            $0.leading.equalTo(tickerCollectionView.snp.trailing).offset(offset)
        }
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        providerLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(tickerCollectionView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview().priority(.high)
        }
        
        return view
    }()
    
    func setupCell() {
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

private extension ReportCell {
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
