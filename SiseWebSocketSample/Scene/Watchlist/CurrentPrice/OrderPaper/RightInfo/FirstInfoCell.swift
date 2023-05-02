//
//  FirstInfoCell.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/30.
//

import UIKit
import SnapKit

final class FirstInfoCell: UICollectionViewCell {
    static let identifier = "FirstInfoCell"
    
    private lazy var fiftyTwoWeekHighView = TitleAndValueView(titleValue: "52 Week\nHigh", contentValue: "19.6800", topOffset: 4, bottomOffset: 4)
    
    private lazy var fiftyTwoWeekLowView = TitleAndValueView(titleValue: "52 Week\nLow", contentValue: "6.0945", topOffset: 4, bottomOffset: 4)
    
    private lazy var priceQuotationView = TitleAndValueView(titleValue: "Price\nQuotation", contentValue: "0.0100", topOffset: 4, bottomOffset: 4)
    
    private let separatorView = SeparatorView(
        size: 0.5,
        bgColor: .lightGray.withAlphaComponent(0.3),
        direction: .horizontal
    )
    
    private lazy var openTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        label.textColor = .lightGray
        label.text = "Open"
        
        return label
    }()
    
    private lazy var openValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .lightGray
        label.text = "8.3900"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var openPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .gray
        label.text = "(0.12%)"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var highTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        label.textColor = .red
        label.text = "High"
        
        return label
    }()
    
    private lazy var highValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .red
        label.text = "8.4700"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var highPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .red
        label.text = "(0.83%)"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var lowTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        label.textColor = .blue
        label.text = "Low"
        
        return label
    }()
    
    private lazy var lowValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .blue
        label.text = "8.3600"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var lowPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .blue
        label.text = "(0.48%)"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            fiftyTwoWeekHighView,
            fiftyTwoWeekLowView,
            priceQuotationView,
            separatorView,
            openTitleLabel,
            openValueLabel,
            openPercentLabel,
            highTitleLabel,
            highValueLabel,
            highPercentLabel,
            lowTitleLabel,
            lowValueLabel,
            lowPercentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        fiftyTwoWeekHighView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset).priority(.low)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    
        fiftyTwoWeekLowView.snp.makeConstraints {
            $0.top.equalTo(fiftyTwoWeekHighView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
       
        priceQuotationView.snp.makeConstraints {
            $0.top.equalTo(fiftyTwoWeekLowView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(priceQuotationView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        openTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
        }
        
        openTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        openValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(openTitleLabel)
            $0.leading.equalTo(openTitleLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        openPercentLabel.snp.makeConstraints {
            $0.top.equalTo(openValueLabel.snp.bottom).offset(offset / 2)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            
        }
        
        highTitleLabel.snp.makeConstraints {
            $0.top.equalTo(openPercentLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
        }
        
        highTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        highValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(highTitleLabel)
            $0.leading.equalTo(highTitleLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        highPercentLabel.snp.makeConstraints {
            $0.top.equalTo(highValueLabel.snp.bottom).offset(offset / 2)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        lowTitleLabel.snp.makeConstraints {
            $0.top.equalTo(highPercentLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
        }
        
        lowTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        lowValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(lowTitleLabel)
            $0.leading.equalTo(lowTitleLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        lowPercentLabel.snp.makeConstraints {
            $0.top.equalTo(lowValueLabel.snp.bottom).offset(offset / 2)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
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
    
    func setupCell(firstInfo: FirstInfoData) {
        fiftyTwoWeekHighView.setData(value: firstInfo.fiftyTwoWeekHigh.fourPointStringNumber)
        fiftyTwoWeekLowView.setData(value: firstInfo.fiftyTwoWeekLow.fourPointStringNumber)
        priceQuotationView.setData(value: firstInfo.priceQuotation.fourPointStringNumber)
        openValueLabel.text = firstInfo.open.fourPointStringNumber
        openPercentLabel.text = firstInfo.openPercent.twoPointStringNumber
        highValueLabel.text = firstInfo.high.fourPointStringNumber
        highPercentLabel.text = firstInfo.highPercent.twoPointStringNumber
        lowValueLabel.text = firstInfo.low.fourPointStringNumber
        lowPercentLabel.text = firstInfo.lowPercent.twoPointStringNumber
    }
}

private extension FirstInfoCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}



#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct FirstInfoCellPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            FirstInfoCell()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 300.0)
    }
}


#endif

