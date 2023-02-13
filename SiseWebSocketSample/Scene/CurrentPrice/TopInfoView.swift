//
//  TopInfoView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/14.
//

import UIKit
import SnapKit

final class TopInfoView: UIView {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APPLE"
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.text = "APPL"
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "151.0100"
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .label

        return label
    }()
    
    private lazy var regularMarketChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "0.3700"
        label.font = .systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var regularMargketChangePercentLabel: UILabel = {
        let label = UILabel()
        label.text = "0.25%"
        label.font = .systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        [
            nameLabel,
            codeLabel,
            currentPriceLabel,
            regularMarketChangeLabel,
            regularMargketChangePercentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(offset)
        }
        
        codeLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(offset)
        }
        
        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(offset)
            $0.leading.equalTo(nameLabel)
        }
        
        regularMarketChangeLabel.snp.makeConstraints {
            $0.top.equalTo(currentPriceLabel.snp.bottom).offset(offset)
            $0.leading.equalTo(currentPriceLabel)
        }
        
        regularMargketChangePercentLabel.snp.makeConstraints {
            $0.centerY.equalTo(regularMarketChangeLabel)
            $0.leading.equalTo(regularMarketChangeLabel.snp.trailing).offset(offset)
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
    
    func setPriceLabelColor(isUp: Bool) {
        if isUp {
            currentPriceLabel.textColor = .red
            regularMarketChangeLabel.textColor = .red
            regularMargketChangePercentLabel.textColor = .red
        } else {
            currentPriceLabel.textColor = .blue
            regularMarketChangeLabel.textColor = .blue
            regularMargketChangePercentLabel.textColor = .blue
        }
    }
    
    func setName(value: String) {
        self.nameLabel.text = value
    }
    
    func setCode(value: String) {
        self.codeLabel.text = value
    }
    
    func setCurrentPrice(value: String) {
        self.currentPriceLabel.text = value
    }
    
    func setMargetChange(value: String) {
        self.regularMarketChangeLabel.text = value
    }
    
    func setMargetChangePercent(value: String) {
        self.regularMargketChangePercentLabel.text = value
    }
}

private extension TopInfoView {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
