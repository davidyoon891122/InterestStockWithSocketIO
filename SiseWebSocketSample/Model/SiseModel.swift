//
//  SiseModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation

struct SiseModel: Decodable {
    var code: String
    var currentPrice: String
    var percentChange: String
    var prevPriceRate: String
    var isUp: Bool
}
