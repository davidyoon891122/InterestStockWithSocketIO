//
//  FirstInfoData.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/30.
//

import Foundation

struct FirstInfoData: Hashable {
    var fiftyTwoWeekHigh: Double
    var fiftyTwoWeekLow: Double
    var priceQuotation: Double
    var open: Double
    var openPercent: Double
    var high: Double
    var highPercent: Double
    var low: Double
    var lowPercent: Double
}

extension FirstInfoData {
    static let item =
        FirstInfoData(
            fiftyTwoWeekHigh: 8.4600,
            fiftyTwoWeekLow: 6.0945,
            priceQuotation: 0.0100,
            open: 8.3900,
            openPercent: 0.68,
            high: 8.4600,
            highPercent: 0,
            low: 8.3600,
            lowPercent: 0.32
        )
    
}
