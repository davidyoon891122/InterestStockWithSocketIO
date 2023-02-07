//
//  InterestListResponseEntity.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/07.
//

import Foundation

struct InterestListResponseEntity: Decodable {
    let stocks: [InterestStockEntity]
}

struct InterestStockEntity: Decodable {
    let code: String
}
