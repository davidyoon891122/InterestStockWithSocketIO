//
//  CurrentPriceModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation

struct CurrentPriceModel {
    var stockName: String
    var currentPrice: Double
    var percentChange: Double
    var prevPriceRate: Double
    var isUp: Bool
    var symbol: String
}
