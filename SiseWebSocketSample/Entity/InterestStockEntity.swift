//
//  InterestStockEntity.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation

struct InterestStockEntity: Decodable {
    var stockName: String
    var stockCode: String
    var currentPrice: Float
    var percentChange: Float
    var prevPriceRate: Float
    var isUp: Bool
}
