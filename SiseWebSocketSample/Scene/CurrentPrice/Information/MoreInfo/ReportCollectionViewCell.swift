//
//  ReportCollectionViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/13.
//

import UIKit
import SnapKit

final class ReportCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReportCollectionViewCell"
    
    private let reportView = ReportView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(reportView)
        
        reportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

private extension ReportCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
