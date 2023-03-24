//
//  NewsContentCollectionViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/22.
//

import UIKit
import SnapKit

final class NewsContentCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewsContentCollectionViewCell"
    
    private lazy var sourceCompanyLabel: UILabel = {
        let label = UILabel()
        label.text = "NYTimes"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "2023.02.22"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아마존(AWS), AWS 둔화 큰 문제 아닐 것, top pick-MS"
        label.textColor = .label
        label.numberOfLines = 3
        
        return label
    }()
    
    private let separatorView = SeparatorView(
        size: 1.0,
        bgColor: .lightGray.withAlphaComponent(0.5),
        direction: .horizontal
    )
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            sourceCompanyLabel,
            dateLabel,
            titleLabel,
            separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        sourceCompanyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(sourceCompanyLabel)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(sourceCompanyLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
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

private extension NewsContentCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
