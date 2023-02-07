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
    let regularMarketPrice: Float
    let regularMarketChange: Float
    let regularMarketChangePercent: Float
    let displayName: String
}
