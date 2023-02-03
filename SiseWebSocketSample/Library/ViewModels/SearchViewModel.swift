//
//  SearchViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import Foundation
import RxSwift

protocol SearchViewModelInput {
    func requestStocks()
}

protocol SearchViewModelOutput {
    var stockModels: PublishSubject<[StockModel]> { get }
}

protocol SearchViewModelType {
    var inputs: SearchViewModelInput { get }
    var outputs: SearchViewModelOutput { get }
}

final class SearchViewModel: SearchViewModelType, SearchViewModelInput, SearchViewModelOutput {
    var inputs: SearchViewModelInput { self }
    
    var outputs: SearchViewModelOutput { self }
    
    private var stocks: [StockModel] = []
    
    var stockModels: PublishSubject<[StockModel]> = .init()
    
    func requestStocks() {
        stocks = MasterParser.overseaStocks
        stockModels.onNext(stocks)
    }
}
