//
//  CurrentPriceViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/13.
//

import UIKit
import SnapKit

final class CurrentPriceViewController: UIViewController {
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
    
    private var code: CurrentPriceModel
    
    init(code: CurrentPriceModel) {
        self.code = code
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = code.stockName
        codeLabel.text = code.symbol
        currentPriceLabel.text = "\(code.currentPrice)"
        regularMarketChangeLabel.text = "\(code.prevPriceRate)"
        regularMargketChangePercentLabel.text = "\(code.percentChange)"
        setPriceLabelColor()
        
        configureNavigation()
        setupViews()
    }
}

private extension CurrentPriceViewController {
    func configureNavigation() {
        navigationItem.title = "\(code.stockName)"
    }
    
    func setupViews() {
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
    }
    
    func setPriceLabelColor() {
        if code.isUp {
            currentPriceLabel.textColor = .red
            regularMarketChangeLabel.textColor = .red
            regularMargketChangePercentLabel.textColor = .red
        } else {
            currentPriceLabel.textColor = .blue
            regularMarketChangeLabel.textColor = .blue
            regularMargketChangePercentLabel.textColor = .blue
        }
    }
}
