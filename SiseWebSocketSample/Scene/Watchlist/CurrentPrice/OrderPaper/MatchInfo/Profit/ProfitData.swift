//
//  ProfitData.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/11.
//

import Foundation


struct ProfitData: Hashable {
    let cashProfit: Double
    let cashPrice: Double
    let creditProfit: Double
    let creditPrice: Double
    let guaranteeProfit: Double
    let guaranteePrice: Double
}

extension ProfitData {
    static let item = ProfitData(cashProfit: 3.25, cashPrice: 8.8500, creditProfit: 4.10, creditPrice: 8.9000, guaranteeProfit: 10.5, guaranteePrice: 8.2000)
}
