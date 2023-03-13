//
//  UpsellCollectionViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit
import SnapKit

final class UpsellCollectionViewCell: UICollectionViewCell {
    static let identifier = "UpsellCollectionViewCell"
    
    private let bullishSummaryView = UpsellSummaryView(title: "Bullish", iconName: "arrow.up.right.square")
    
    private let bearishSummaryView = UpsellSummaryView(title: "Bearish", iconName: "arrow.down.backward.square")
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            bullishSummaryView,
            bearishSummaryView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        bullishSummaryView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        bearishSummaryView.snp.makeConstraints {
            $0.top.equalTo(bullishSummaryView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()

    private var insights: InsightsResponseEntity?
    
    func setupCell(insights: InsightsResponseEntity) {
        setupViews()
        if let bullishSummary = insights.result?.upsell.msBullishSummary {
            bullishSummaryView.setUpsellData(insights: bullishSummary)
        }
        
        if let bearishSummary = insights.result?.upsell.msBearishSummary {
            bearishSummaryView.setUpsellData(insights: bearishSummary)
        }
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

private extension UpsellCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
