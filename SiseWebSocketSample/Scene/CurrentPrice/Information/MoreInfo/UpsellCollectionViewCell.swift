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
    
    private let bullishSummaryView = UpsellSummaryView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            bullishSummaryView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        bullishSummaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return view
    }()

    private var insights: InsightsResponseEntity?
    
    func setupCell(insights: InsightsResponseEntity) {
        setupViews()
        bullishSummaryView.setUpsellData(insights: insights)
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
