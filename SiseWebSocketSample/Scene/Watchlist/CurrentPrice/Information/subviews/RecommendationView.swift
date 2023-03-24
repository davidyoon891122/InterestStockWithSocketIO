//
//  RecommendationView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/02.
//

import UIKit
import SnapKit

final class RecommendationView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Recommendation"
        return label
    }()
    
    private lazy var targetPriceLabelView = TitleValueLabelView(title: "TargetPrice")
    private lazy var providerLabelView = TitleValueLabelView(title: "Provider")
    private lazy var ratingLabelView = TitleValueLabelView(title: "Rating")
    
    
    private lazy var labelVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        [
            targetPriceLabelView,
            providerLabelView,
            ratingLabelView
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
            labelVStackView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        labelVStackView.snp.makeConstraints {
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
    
    func setTargetPriceValue(value: String) {
        targetPriceLabelView.setValueLabel(value: value)
    }
    
    func setProviderLabelView(value: String) {
        providerLabelView.setValueLabel(value: value)
    }
    
    func setRatingLabelView(value: String) {
        ratingLabelView.setValueLabel(value: value)
    }
}

private extension RecommendationView {
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
