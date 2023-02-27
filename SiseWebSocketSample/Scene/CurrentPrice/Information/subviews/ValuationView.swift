//
//  ValuationView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/27.
//

import UIKit
import SnapKit

final class ValuationView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Valuation"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var colorLabelView = TitleValueLabelView(title: "Color")
    private lazy var descriptionLabelView = TitleValueLabelView(title: "description")
    private lazy var discountLabelView = TitleValueLabelView(title: "discount")
    private lazy var relativeValueLabelView = TitleValueLabelView(title: "relativeValue")
    private lazy var providerLabelView = TitleValueLabelView(title: "provider")
    
    
    private lazy var labelVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        [
            colorLabelView,
            descriptionLabelView,
            discountLabelView,
            relativeValueLabelView,
            providerLabelView
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
}

private extension ValuationView {
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

