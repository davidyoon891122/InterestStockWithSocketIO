//
//  ReportHeaderView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/15.
//

import UIKit
import SnapKit

final class ReportHeaderView: UICollectionReusableView {
    static let identifier = "ReportHeaderView"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.text = "Report"
        
        return label
    }()
    
    private let separatorView = SeparatorView(
        size: 0.5,
        bgColor: .lightGray.withAlphaComponent(0.3),
        direction: .horizontal
    )
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            titleLabel,
            separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset / 2)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset / 2)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

private extension ReportHeaderView {
    func setupViews() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
