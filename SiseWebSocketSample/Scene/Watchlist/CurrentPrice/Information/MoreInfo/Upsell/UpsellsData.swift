//
//  UpsellsData.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/13.
//

import Foundation


class UpsellData: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UpsellData, rhs: UpsellData) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var content: String
    
    init(content: String) {
        self.content = content
    }
}

extension UpsellData {
    static let allUpsells = [
        UpsellData(content: "2023-03-13 10:31:28.446: StockRepository requestStockInfo -> Event next(CurrentPriceResponseEntity(result: [SiseWebSocketSample.CurrentPriceEntity(regularMarketPrice: 148.5, regularMarketChange: -2.0899963, regularMarketChangePercent: -1.387872, displayName:, fiftyTwoWeekRange: SiseWebSocketSample.CurrentPriceFiftyTwoWeekRange(low: 124.17, high: 179.61))]))"),
        UpsellData(content: "2023-03-13 10:31:28.446: StockRepository requestStockInfo -> Event next(CurrentPriceResponseEntity(result: [SiseWebSocketSample.CurrentPriceEntity(regularMarketPrice: 148.5, regularMarketChange: -2.0899963, regularMarketChangePercent: -1.387872, displayName:, fiftyTwoWeekRange: SiseWebSocketSample.CurrentPriceFiftyTwoWeekRange(low: 124.17, high: 179.61))]))"),
        UpsellData(content: "2023-03-13 10:31:28.446: StockRepository requestStockInfo -> Event next(CurrentPriceResponseEntity(result: [SiseWebSocketSample.CurrentPriceEntity(regularMarketPrice: 148.5, regularMarketChange: -2.0899963, regularMarketChangePercent: -1.387872, displayName:, fiftyTwoWeekRange: SiseWebSocketSample.CurrentPriceFiftyTwoWeekRange(low: 124.17, high: 179.61))]))"),
        UpsellData(content: "2023-03-13 10:31:28.446: StockRepository requestStockInfo -> Event next(CurrentPriceResponseEntity(result: [SiseWebSocketSample.CurrentPriceEntity(regularMarketPrice: 148.5, regularMarketChange: -2.0899963, regularMarketChangePercent: -1.387872, displayName:, fiftyTwoWeekRange: SiseWebSocketSample.CurrentPriceFiftyTwoWeekRange(low: 124.17, high: 179.61))]))")
    
    ]
}
