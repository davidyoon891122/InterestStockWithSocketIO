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
    
    private lazy var providerLabel = TitleValueLabelView(title: "Provider")
    
    private lazy var reportDateLabel = TitleValueLabelView(title: "Report Date")
    
    private lazy var reportTitleLabel = TitleValueLabelView(title: "Report Title")
    
    private lazy var reportTypeLabel = TitleValueLabelView(title: "Report Type")
    
    private lazy var targetPriceLabel = TitleValueLabelView(title: "Target Price")
    
    private lazy var targetPriceStatusLabel = TitleValueLabelView(title: "Price Status")
    
    private lazy var investmentRatingLabel = TitleValueLabelView(title: "Investment Rating")
    
    private lazy var tickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private lazy var labelHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        [
            providerLabel,
            reportDateLabel,
            reportTitleLabel,
            reportTypeLabel,
            targetPriceLabel,
            targetPriceStatusLabel,
            investmentRatingLabel,
            tickerCollectionView,
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            labelHStackView,
            tickerCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        labelHStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        tickerCollectionView.snp.makeConstraints {
            $0.top.equalTo(labelHStackView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50.0)
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
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
