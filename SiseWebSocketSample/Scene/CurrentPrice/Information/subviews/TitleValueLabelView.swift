//
//  TitleValueLabelView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import UIKit
import SnapKit

final class TitleValueLabelView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var separatorView = SeparatorView(
        size: 1.0,
        bgColor: .lightGray.withAlphaComponent(0.5),
        direction: .horizontal
    )
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            titleLabel,
            valueLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-offset)
            $0.width.lessThanOrEqualTo(130.0)
        }
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleLabel)
        }
        
        return view
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValueLabel(value: String) {
        valueLabel.text = value
    }
}

private extension TitleValueLabelView {
    func setupViews() {
        addSubview(containerView)
        let offset: CGFloat = 16.0
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview()
        }
    }
}
