//
//  ReportData.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/13.
//

import Foundation

final class ReportData: Hashable {
    static func == (lhs: ReportData, rhs: ReportData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID()
    var provider: String
    var reportDate: String
    var reportTitle: String
    var reportType: String
    var targetPrice: Int?
    var targetPriceStatus: String?
    var investmentRating: String?
    var tickers: [String]
    
    init(
        provider: String,
        reportDate: String,
        reportTitle: String,
        reportType: String,
        targetPrice: Int?,
        targetPriceStatus: String?,
        investmentRating: String?,
        tickers: [String]
    ) {
        self.provider = provider
        self.reportDate = reportDate
        self.reportTitle = reportTitle
        self.reportType = reportType
        self.targetPrice = targetPrice
        self.targetPriceStatus = targetPriceStatus
        self.investmentRating = investmentRating
        self.tickers = tickers
    }
}


extension ReportData {
    static let allReport = [
        ReportData(provider: "JP", reportDate: "2023.03.10", reportTitle: "SVC backrupted!", reportType: "Argent", targetPrice: 300000, targetPriceStatus: "bullish", investmentRating: "300", tickers: ["AAPL", "TSLA"]),
        ReportData(provider: "JP", reportDate: "2023.03.10", reportTitle: "SVC backrupted!", reportType: "Argent", targetPrice: 300000, targetPriceStatus: "bullish", investmentRating: "300", tickers: ["AAPL", "TSLA"]),
        ReportData(provider: "JP", reportDate: "2023.03.10", reportTitle: "SVC backrupted!", reportType: "Argent", targetPrice: 300000, targetPriceStatus: "bullish", investmentRating: "300", tickers: ["AAPL", "TSLA"]),
        ReportData(provider: "JP", reportDate: "2023.03.10", reportTitle: "SVC backrupted!", reportType: "Argent", targetPrice: 300000, targetPriceStatus: "bullish", investmentRating: "300", tickers: ["AAPL", "TSLA"])
    ]
}
