//
//  OrderTableView.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/29.
//

import UIKit
import SnapKit

final class OrderTableView: UIView {
    private lazy var bidVolumeView = BidVolumeView(viewModel: viewModel)
    
    private lazy var askPriceView = AskPriceView(viewModel: viewModel)
    
    private lazy var rightInfoView = RightInfoView(viewModel: viewModel)
    
    private lazy var topHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        
        bidVolumeView.snp.makeConstraints {
            $0.width.equalTo(Constants.OrderPaper.volumeViewWidth)
        }
        
        askPriceView.snp.makeConstraints {
            $0.width.equalTo(Constants.OrderPaper.priceViewWidth)
        }
        
        rightInfoView.snp.makeConstraints {
            $0.width.equalTo(Constants.OrderPaper.volumeViewWidth)
        }
        
        [
            bidVolumeView,
            askPriceView,
            rightInfoView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var matchStrengthView = MatchStrengthView(viewModel: viewModel)
    
    private lazy var bidPriceView = BidPriceView(viewModel: viewModel)
    
    private lazy var askVolumnView = AskVolumeView(viewModel: viewModel)
    
    private lazy var bottomHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        
        matchStrengthView.snp.makeConstraints {
            $0.width.equalTo(Constants.OrderPaper.volumeViewWidth)
        }
        
        bidPriceView.snp.makeConstraints {
            $0.width.equalTo(Constants.OrderPaper.priceViewWidth)
        }
        
        askVolumnView.snp.makeConstraints {
            $0.width.equalTo(Constants.OrderPaper.volumeViewWidth)
        }
        
        [
            matchStrengthView,
            bidPriceView,
            askVolumnView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        
        return stackView
    }()
    
    private var viewModel: MainViewModelType
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfoData(stockInfo: StockInfoData) {
        bidVolumeView.setInfoData(stockInfo: stockInfo)
        askPriceView.setInfoData(stockInfo: stockInfo)
        rightInfoView.setInfoData(stockInfo: stockInfo)
        matchStrengthView.setDataInfo(stockInfo: stockInfo)
        bidPriceView.setDataInfo(stockInfo: stockInfo)
        askVolumnView.setInfoData(stockInfo: stockInfo)
    }
}

private extension OrderTableView {
    func setupViews() {
        [
            topHStackView,
            bottomHStackView
        ]
            .forEach {
                addSubview($0)
            }
        
        topHStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.OrderPaper.orderPaperHeight)
        }
        
        bottomHStackView.snp.makeConstraints {
            $0.top.equalTo(topHStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.OrderPaper.orderPaperHeight)
            $0.bottom.equalToSuperview()
        }
    }
}




#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct OrderTableViewPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            OrderTableView(viewModel: MainViewModel())
        }
        .frame(width: UIScreen.main.bounds.width, height: Constants.OrderPaper.orderPaperHeight * 2)
    }
}


#endif
