//
//  SecondInfoData.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/30.
//

import Foundation

struct SecondInfoData: Hashable {
    var loanPosibility: Bool
    var loanRage: Double
    var per: Double
    var pbr: Double
    var eps: Double
    var totalIssuedStock: Int
    var marketCap: Int
    var type: String
}

extension SecondInfoData {
    static let item = SecondInfoData(
        loanPosibility: false,
        loanRage: 3.20,
        per: 20.10,
        pbr: 10.5,
        eps: 2.1,
        totalIssuedStock: 143250,
        marketCap: 1211895,
        type: "ETF"
    )
}
