//
//  KeyTechnicalsView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/27.
//

import UIKit
import SnapKit

final class KeyTechnicalsView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "KeyTechnicals"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var supportLabelView = TitleValueLabelView(title: "Support")
    private lazy var resistanceLabelView = TitleValueLabelView(title: "Resistance")
    private lazy var stopLossLabelView = TitleValueLabelView(title: "StopLoss")
    
    private lazy var contentVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        [
            supportLabelView,
            resistanceLabelView,
            stopLossLabelView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8.0
        [
            titleLabel,
            contentVStackView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview()
        }
        
        contentVStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-offset)
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension KeyTechnicalsView {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview()
        }
    }
}
