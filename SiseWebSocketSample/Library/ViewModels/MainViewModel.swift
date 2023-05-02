//
//  MainViewModel.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/12.
//

import Foundation
import RxSwift

protocol MainViewModelInput {
    func requestStockInfo(code: String)
    func requestOrderPopup(priceData: PriceData)
}

protocol MainViewModelOutput {
    var stockInfoPublishSubject: PublishSubject<StockInfoData> { get }
}

protocol MainViewModelType {
    var inputs: MainViewModelInput { get }
    var outputs: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelType, MainViewModelInput, MainViewModelOutput {
    var inputs: MainViewModelInput { self }
    var outputs: MainViewModelOutput { self }
    
    var stockInfoPublishSubject: PublishSubject<StockInfoData> = .init()
    
    func requestStockInfo(code: String) {
        let stockInfo = StockInfoData.item
        stockInfoPublishSubject.onNext(stockInfo)
    }
    
    func requestOrderPopup(priceData: PriceData) {
        
    }
}
