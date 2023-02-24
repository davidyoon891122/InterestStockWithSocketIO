//
//  InformationTechnicalViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import UIKit
import SnapKit

final class InformationTechnicalViewCell: UICollectionViewCell {
    static let identifier = "InformationTechnicalViewCell"
    
    private lazy var providerLabelView = TitleValueLabelView(title: "Provider")
    private lazy var sectorLabelView = TitleValueLabelView(title: "Sector")
    
    private lazy var shortTermView = TermView(title: "Short Term Outlook")
    private lazy var intermediateTermView = TermView(title: "Intermediate Term Outlook")
    private lazy var longTermView = TermView(title: "Long Term Outlook")
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            providerLabelView,
            sectorLabelView,
            shortTermView,
            intermediateTermView,
            longTermView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        providerLabelView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        sectorLabelView.snp.makeConstraints {
            $0.top.equalTo(providerLabelView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        shortTermView.snp.makeConstraints {
            $0.top.equalTo(sectorLabelView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        intermediateTermView.snp.makeConstraints {
            $0.top.equalTo(shortTermView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        longTermView.snp.makeConstraints {
            $0.top.equalTo(intermediateTermView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    func setupCell() {
        
        providerLabelView.setValueLabel(value: "Trading Central")
        sectorLabelView.setValueLabel(value: "Technology")
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

private extension InformationTechnicalViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
