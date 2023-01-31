//
//  MasterModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/31.
//

import Foundation

struct MasterModel: Decodable {
    let stocks: [StockModel]
}
