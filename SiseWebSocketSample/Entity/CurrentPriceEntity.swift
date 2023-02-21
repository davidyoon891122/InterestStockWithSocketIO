//
//  CurrentPriceEntity.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/07.
//

import Foundation

struct CurrentPriceResponseEntity: Decodable {
    let result: [CurrentPriceEntity]
}

struct CurrentPriceEntity: Decodable {
    let regularMarketPrice: Double
    let regularMarketChange: Double
    let regularMarketChangePercent: Double
    let displayName: String?
    let longName: String
    let symbol: String
    let currency: String
    let exchange: String
    let fiftyTwoWeekRange: CurrentPriceFiftyTwoWeekRange
    
}
        
struct CurrentPriceFiftyTwoWeekRange: Decodable {
    let low: Double
    let high: Double
}
