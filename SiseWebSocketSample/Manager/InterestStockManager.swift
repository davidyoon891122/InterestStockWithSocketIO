//
//  InterestStockManager.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/06.
//

import Foundation


class InterestStockManager {
    static let shared = InterestStockManager()
    
    private var interestStocks: [InterestStockModel] = []
    
    func addInterestStock(stockModel: InterestStockModel) {
        interestStocks.append(stockModel)
    }
    
    func setInteresetStocks(stocks: [InterestStockModel]) {
        self.interestStocks = stocks
    }
    
    func getInterestStocks() -> [InterestStockModel] {
        return self.interestStocks
    }
    
}
