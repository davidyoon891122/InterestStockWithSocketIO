//
//  PriceData.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/30.
//

import Foundation

final class PriceData: Hashable {
    var id = UUID()
    
    var price: Double
    var change: Double
    
    init(price: Double, change: Double) {
        self.price = price
        self.change = change
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PriceData, rhs: PriceData) -> Bool {
        lhs.id == rhs.id
    }
}

extension PriceData {
    static let allItem = [
        PriceData(price: 8.5300, change: 0.83),
        PriceData(price: 8.5200, change: 0.71),
        PriceData(price: 8.5100, change: 0.59),
        PriceData(price: 8.5000, change: 0.47),
        PriceData(price: 8.4900, change: 0.36),
        PriceData(price: 8.4800, change: 0.24),
        PriceData(price: 8.4700, change: 0.12),
        PriceData(price: 8.4600, change: 0.00),
        PriceData(price: 8.4500, change: -0.12),
        PriceData(price: 8.4400, change: -0.24)
    ]
}
