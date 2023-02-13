//
//  CurrentPriceModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation

struct CurrentPriceModel {
    var stockName: String
    var currentPrice: Float
    var percentChange: Float
    var prevPriceRate: Float
    var isUp: Bool
    var symbol: String
}
