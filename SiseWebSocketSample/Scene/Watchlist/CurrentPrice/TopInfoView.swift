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
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.text = "APPL"
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var firstHSeparatorView = SeparatorView(
        size: 1.0,
        bgColor: .lightGray.withAlphaComponent(0.5),
        direction: .vertical
    )
    
    private lazy var secondHSeparatorView = SeparatorView(
        size: 1.0,
        bgColor: .lightGray.withAlphaComponent(0.5),
        direction: .vertical
    )
    
    
    private lazy var nameView: UIView = {
        let view = UIView()
        [
            nameLabel,
            firstHSeparatorView,
            codeLabel,
            secondHSeparatorView,
            currencyLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 8.0
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-offset)
            $0.width.lessThanOrEqualTo(100.0)
        }
        
        firstHSeparatorView.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(offset)
            $0.top.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        codeLabel.snp.makeConstraints {
            $0.leading.equalTo(firstHSeparatorView.snp.trailing).offset(offset)
            $0.centerY.equalTo(firstHSeparatorView)
        }
        
        secondHSeparatorView.snp.makeConstraints {
            $0.leading.equalTo(codeLabel.snp.trailing).offset(offset)
            $0.centerY.equalTo(codeLabel)
            $0.top.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        currencyLabel.snp.makeConstraints {
            $0.leading.equalTo(secondHSeparatorView.snp.trailing).offset(offset)
            $0.centerY.equalTo(secondHSeparatorView)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "151.0100"
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .label

        return label
    }()
    
    private lazy var regularMarketChangeArrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.tintColor = .red
        
        return imageView
    }()
    
    private lazy var regularMarketChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "0.3700"
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        
        return label
    }()
    
    private lazy var regularMargketChangePercentLabel: UILabel = {
        let label = UILabel()
        label.text = "0.25%"
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        
        return label
    }()
    
    private lazy var changeView: UIView = {
        let view = UIView()
        [
            regularMarketChangeArrowImageView,
            regularMarketChangeLabel,
            regularMargketChangePercentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        regularMarketChangeArrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(12.0)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        regularMarketChangeLabel.snp.makeConstraints {
            $0.centerY.equalTo(regularMarketChangeArrowImageView)
            $0.leading.equalTo(regularMarketChangeArrowImageView.snp.trailing).offset(offset)
        }
        
        regularMargketChangePercentLabel.snp.makeConstraints {
            $0.centerY.equalTo(regularMarketChangeLabel)
            $0.leading.equalTo(regularMarketChangeLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview()
        }
        
        return view
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        [
            nameView,
            buttonView,
            currentPriceLabel,
            changeView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        
        nameView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
        }
        
        buttonView.snp.makeConstraints {
            $0.centerY.equalTo(nameView)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom)
            $0.leading.equalTo(nameView)
        }
        
        changeView.snp.makeConstraints {
            $0.top.equalTo(currentPriceLabel.snp.bottom).offset(offset/2)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset/2)
        }
        
        
        return view
    }()
    
    private lazy var loanButton: UIButton = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8.0)
        var containter = AttributeContainer()
        containter.font = .systemFont(ofSize: 10.0)
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.preferredSymbolConfigurationForImage = imageConfig
        buttonConfig.attributedTitle = AttributedString("Loan", attributes: containter)
        buttonConfig.baseBackgroundColor = .black
        buttonConfig.contentInsets = .init(top: 4.0, leading: 4.0, bottom: 4.0, trailing: 4.0)
        buttonConfig.image = UIImage(systemName: "arrowtriangle.right")
        buttonConfig.imagePadding = 4.0
        buttonConfig.imagePlacement = .trailing
        
        let button = UIButton(configuration: buttonConfig)

        button.setTitleColor(.gray, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 4.0
        button.tintColor = .gray
        
        return button
    }()
    
    private lazy var currencyChangeButton: UIButton = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8.0)
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 10.0)
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.preferredSymbolConfigurationForImage = imageConfig
        buttonConfig.title = "KRW"
        buttonConfig.attributedTitle = AttributedString("KRW", attributes: container)
        
        buttonConfig.image = UIImage(systemName: "arrow.up.and.down")
        buttonConfig.imagePadding = 4.0
        buttonConfig.imagePlacement = .leading
        buttonConfig.contentInsets = .init(top: 4.0, leading: 4.0, bottom: 4.0, trailing: 4.0)
        
        let button = UIButton(configuration: buttonConfig)

        button.setTitleColor(.gray, for: .normal)
        button.tintColor = .gray
        
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 4.0
        
        return button
    }()
    
    private lazy var interestButton: UIButton = {
        let button = UIButton()
       
        
        return button
    }()
    
    private lazy var buttonView: UIView = {
        let view = UIView()
        [
            loanButton,
            currencyChangeButton
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        loanButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview()
            $0.height.equalTo(14.0)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        currencyChangeButton.snp.makeConstraints {
            $0.centerY.equalTo(loanButton)
            $0.height.equalTo(14.0)
            $0.leading.equalTo(loanButton.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
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
            regularMarketChangeArrowImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            regularMarketChangeArrowImageView.tintColor = UIColor(named: "UpColor")
        } else {
            currentPriceLabel.textColor = .blue
            regularMarketChangeLabel.textColor = .blue
            regularMargketChangePercentLabel.textColor = .blue
            regularMarketChangeArrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            regularMarketChangeArrowImageView.tintColor = UIColor(named: "DownColor")
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
