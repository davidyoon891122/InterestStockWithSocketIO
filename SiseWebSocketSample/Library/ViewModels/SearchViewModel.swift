//
//  SearchViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import Foundation
import RxSwift

protocol SearchViewModelInput {
    func requestStocks(page: Int)
    func requestAddStockToList(stock: InterestStockModel)
    func requestDeleteStockFromList(stock: InterestStockModel)
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
    
    private let repository = InterestRepository()
    
    var stockModels: PublishSubject<[StockModel]> = .init()
    
    var currnetPageModel: [StockModel] = []
    
    private let itemsPerPage = 100
    var pageCount = 0
    
    func requestStocks(page: Int) {
        let interestStocks = InterestStockManager.shared.getInterestStocks()
        var stocks = MasterParser.overseaStocks
    
        interestStocks.forEach { interestStock in
            if stocks.contains(where: { $0.key == interestStock.code }) {
                stocks[interestStock.code]?.isInterest = true
            }
        }
        
        self.stocks = stocks.map {
            $0.value
        }.sorted { $0.name < $1.name }
        let startPage = itemsPerPage * page
        
        print("\(startPage)...\(startPage + itemsPerPage)")
        
        self.currnetPageModel += Array(self.stocks[startPage...startPage + itemsPerPage])
        
        stockModels.onNext(currnetPageModel)
    }
    
    func requestAddStockToList(stock: InterestStockModel) {
        InterestStockManager.shared.addInterestStock(stockModel: stock)
        repository.inputs.fetchAddingInterestCode(userId: "davidyoon", code: stock.code)
    }
    
    func requestDeleteStockFromList(stock: InterestStockModel) {
        InterestStockManager.shared.removeInterestStock(stockModel: stock)
        repository.inputs.fetchDeletingInterestCode(userId: "davidyoon", code: stock.code)
    }
}
