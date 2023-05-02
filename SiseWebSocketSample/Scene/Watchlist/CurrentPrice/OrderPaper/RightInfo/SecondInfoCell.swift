//
//  SecondInfoCell.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/30.
//

import UIKit
import SnapKit

final class SecondInfoCell: UICollectionViewCell {
    static let identifier = "SecondInfoCell"
    
    private lazy var loanPossibleView = TitleAndValueView(titleValue: "Loan", contentValue: "Impossible")
    private lazy var loanPercentView = TitleAndValueView(titleValue: "Loan\nPercent", contentValue: "-%", topOffset: 2.0)
    private lazy var perView = TitleAndValueView(titleValue: "PER", contentValue: "0.00", topOffset: 2.0)
    private lazy var pbrView = TitleAndValueView(titleValue: "PBR", contentValue: "0.00", topOffset: 2.0)
    private lazy var epsView = TitleAndValueView(titleValue: "EPS", contentValue: "0.00", topOffset: 2.0)
    private lazy var totalIssuedStockView = TitleAndValueView(titleValue: "Isseud\nStock", contentValue: "150,050", topOffset: 2.0)
    private lazy var marketCapView = TitleAndValueView(titleValue: "Market\nCap", contentValue: "1,278,426", topOffset: 2.0)
    private lazy var typeView = TitleAndValueView(titleValue: "Type", contentValue: "ETF", topOffset: 2.0)
    
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            loanPossibleView,
            loanPercentView,
            perView,
            pbrView,
            epsView,
            totalIssuedStockView,
            marketCapView,
            typeView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        loanPossibleView.snp.makeConstraints {
            $0.top.equalToSuperview().priority(.low)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        loanPercentView.snp.makeConstraints {
            $0.top.equalTo(loanPossibleView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        perView.snp.makeConstraints {
            $0.top.equalTo(loanPercentView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        pbrView.snp.makeConstraints {
            $0.top.equalTo(perView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        epsView.snp.makeConstraints {
            $0.top.equalTo(pbrView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        totalIssuedStockView.snp.makeConstraints {
            $0.top.equalTo(epsView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        marketCapView.snp.makeConstraints {
            $0.top.equalTo(totalIssuedStockView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        typeView.snp.makeConstraints {
            $0.top.equalTo(marketCapView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
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
    
    func setInfoData(stockInfo: SecondInfoData) {
        if stockInfo.loanPosibility {
            loanPossibleView.setData(value: "Poss")
        } else {
            loanPossibleView.setData(value: "Impos")
        }
        
        loanPercentView.setData(value: stockInfo.loanRage.twoPointStringNumber + "%")
        perView.setData(value: "\(stockInfo.per)")
        pbrView.setData(value: "\(stockInfo.pbr)")
        epsView.setData(value: "\(stockInfo.eps)")
        totalIssuedStockView.setData(value: "\(stockInfo.totalIssuedStock)")
        marketCapView.setData(value: "\(stockInfo.marketCap)")
        typeView.setData(value: stockInfo.type)
    }
}

private extension SecondInfoCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct SecondInfoCellPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            SecondInfoCell()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 300.0)
    }
}


#endif
