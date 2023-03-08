//
//  SnapshotView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/02.
//

import UIKit
import SnapKit

final class SnapshotView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var innovativenessLabelView = TitleValueLabelView(title: "Innovativeness")
    private lazy var hiringLabelView = TitleValueLabelView(title: "Hiring")
    private lazy var sustainabilityLabelView = TitleValueLabelView(title: "Sustainability")
    private lazy var insiderSentimentsLabelView = TitleValueLabelView(title: "InsiderSentiments")
    private lazy var earningsReportsLabelView = TitleValueLabelView(title: "EarningsReports")
    private lazy var dividendsLabelView = TitleValueLabelView(title: "Dividends")
    
    private lazy var labelVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        [
            innovativenessLabelView,
            hiringLabelView,
            sustainabilityLabelView,
            insiderSentimentsLabelView,
            earningsReportsLabelView,
            dividendsLabelView
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
    
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInnovativenessValue(value: String) {
        innovativenessLabelView.setValueLabel(value: value)
    }
    
    func setHiringValue(value: String) {
        hiringLabelView.setValueLabel(value: value)
    }
    
    func setSustainabilityValue(value: String) {
        sustainabilityLabelView.setValueLabel(value: value)
    }
    
    func setInsiderSentimentsValue(value: String) {
        insiderSentimentsLabelView.setValueLabel(value: value)
    }
    
    func setEarningsReportsValue(value: String) {
        earningsReportsLabelView.setValueLabel(value: value)
    }
    
    func setDividendsValue(value: String) {
        dividendsLabelView.setValueLabel(value: value)
    }
}

private extension SnapshotView {
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

