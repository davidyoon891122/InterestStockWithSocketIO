//
//  ProfitViewCell.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/11.
//

import UIKit
import SnapKit

final class ProfitViewCell: UICollectionViewCell {
    static let identifier = "ProfitViewCell"
    
    private lazy var cashTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cash"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        
        return label
    }()
    
    private let cashProfitView = TitleAndValueView(titleValue: "Profit", contentValue: "-", topOffset: 4.0, leadingOffset: 4.0, bottomOffset: 0.0)
    private let cashBuyPriceView = TitleAndValueView(titleValue: "BuyPrice", contentValue: "-", topOffset: 4.0, leadingOffset: 4.0)
    
    private let cashSeparatoView = SeparatorView(size: 0.5, bgColor: .lightGray.withAlphaComponent(0.5), direction: .horizontal)
    
    private lazy var creditTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Credit"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        
        return label
    }()
    
    private let creditProfitView = TitleAndValueView(titleValue: "Profit", contentValue: "-", topOffset: 4.0, leadingOffset: 4.0, bottomOffset: 0.0)
    private let creditBuyPriceView = TitleAndValueView(titleValue: "BuyPrice", contentValue: "-", topOffset: 4.0, leadingOffset: 4.0)
    
    private let creditSeparatoView = SeparatorView(size: 0.5, bgColor: .lightGray.withAlphaComponent(0.5), direction: .horizontal)
    
    private lazy var guaranteeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Guarantee"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        
        return label
    }()
    
    private let guaranteeProfitView = TitleAndValueView(titleValue: "Profit", contentValue: "-", topOffset: 4.0, leadingOffset: 4.0, bottomOffset: 0.0)
    private let guaranteeBuyPriceView = TitleAndValueView(titleValue: "BuyPrice", contentValue: "-", topOffset: 4.0, leadingOffset: 4.0)
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        [
            cashTitleLabel,
            cashProfitView,
            cashBuyPriceView,
            cashSeparatoView,
            
            creditTitleLabel,
            creditProfitView,
            creditBuyPriceView,
            creditSeparatoView,
            
            guaranteeTitleLabel,
            guaranteeProfitView,
            guaranteeBuyPriceView
        
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 4.0
        cashTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        cashProfitView.snp.makeConstraints {
            $0.top.equalTo(cashTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        cashBuyPriceView.snp.makeConstraints {
            $0.top.equalTo(cashProfitView.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        cashSeparatoView.snp.makeConstraints {
            $0.top.equalTo(cashBuyPriceView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        creditTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cashSeparatoView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        creditProfitView.snp.makeConstraints {
            $0.top.equalTo(creditTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        creditBuyPriceView.snp.makeConstraints {
            $0.top.equalTo(creditProfitView.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        creditSeparatoView.snp.makeConstraints {
            $0.top.equalTo(creditBuyPriceView.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        guaranteeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(creditSeparatoView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        guaranteeProfitView.snp.makeConstraints {
            $0.top.equalTo(guaranteeTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        guaranteeBuyPriceView.snp.makeConstraints {
            $0.top.equalTo(guaranteeProfitView.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
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
    
    func setupCell(profitData: ProfitData) {
        cashProfitView.setData(value: profitData.cashProfit.twoPointStringNumber)
        cashBuyPriceView.setData(value: profitData.cashProfit.fourPointStringNumber)
        
        creditProfitView.setData(value: profitData.creditProfit.twoPointStringNumber)
        creditBuyPriceView.setData(value: profitData.creditPrice.fourPointStringNumber)
        
        guaranteeProfitView.setData(value: profitData.guaranteeProfit.twoPointStringNumber)
        guaranteeBuyPriceView.setData(value: profitData.guaranteePrice.fourPointStringNumber)
    }
}

private extension ProfitViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ProfitViewCellPreviews: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            ProfitViewCell()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 300.0)
    }
}


#endif
