//
//  StockModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/31.
//

import Foundation

struct StockModel: Decodable {
    let code: String
    let name: String
    var isInterest: Bool? = false
}
