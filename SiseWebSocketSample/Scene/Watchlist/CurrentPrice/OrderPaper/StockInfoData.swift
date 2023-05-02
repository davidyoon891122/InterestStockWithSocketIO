//
//  StockInfoData.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/12.
//

import Foundation

struct StockInfoData {
    var name: String
    var code: String
    var currentPrice: Double
    var wonPrice: Double
    var exchange: String
    var marketType: String
    var valueChange: Double
    var percentChange: Double
    var bidVolume: [VolumeData]
    var askPrice: [PriceData]
    var firstInfoData: FirstInfoData
    var secondInfoData: SecondInfoData
    var matchInfoData: MatchInfoData
    var profitData: ProfitData
    var bidPrice: [PriceData]
    var askVolume: [VolumeData]
}

extension StockInfoData {
    static let item = StockInfoData(
        name: "DIREXION DAILY 20Y TREASURY BULL 3X ETF",
        code: "TMF",
        currentPrice: 9.0900,
        wonPrice: 12022,
        exchange: "AMEX",
        marketType: "DAY",
        valueChange: 0.0400,
        percentChange: 0.44,
        bidVolume: [
            VolumeData(volume: 14),
            VolumeData(volume: 54),
            VolumeData(volume: 71),
            VolumeData(volume: 3074),
            VolumeData(volume: 3030),
            VolumeData(volume: 3016),
            VolumeData(volume: 6174),
            VolumeData(volume: 314),
            VolumeData(volume: 7439),
            VolumeData(volume: 14608),
        ],
        askPrice: [
            PriceData(price: 9.1800, change: 0.99),
            PriceData(price: 9.1700, change: 0.88),
            PriceData(price: 9.1600, change: 0.77),
            PriceData(price: 9.1500, change: 0.66),
            PriceData(price: 9.1400, change: 0.55),
            PriceData(price: 9.1300, change: 0.44),
            PriceData(price: 9.1200, change: 0.33),
            PriceData(price: 9.1100, change: 0.22),
            PriceData(price: 9.1000, change: 0.11),
            PriceData(price: 9.0900, change: 0.00)
        ],
        firstInfoData: FirstInfoData(
            fiftyTwoWeekHigh: 16.0189,
            fiftyTwoWeekLow: 6.0945,
            priceQuotation: 0.0100,
            open: 9.1300,
            openPercent: 0.68,
            high: 9.1300,
            highPercent: 1.13,
            low: 9.0800,
            lowPercent: 0.45
        ),
        secondInfoData: SecondInfoData(
            loanPosibility: false,
            loanRage: 0,
            per: 0.00,
            pbr: 0.00,
            eps: 0.00,
            totalIssuedStock: 152150,
            marketCap: 1383043,
            type: "ETF"
        ),
        matchInfoData: MatchInfoData(
            strengthData: MatchInfoStrengthData(matchStrength: 999.99),
            matchData: [
                MatchData(priceValue: 9.0800, volumQuanti: 43),
                MatchData(priceValue: 9.0800, volumQuanti: 25),
                MatchData(priceValue: 9.0800, volumQuanti: 5),
                MatchData(priceValue: 9.0800, volumQuanti: 2),
                MatchData(priceValue: 9.0800, volumQuanti: 10),
                MatchData(priceValue: 9.0800, volumQuanti: 234),
                MatchData(priceValue: 9.0800, volumQuanti: 10),
                MatchData(priceValue: 9.0800, volumQuanti: 71),
                MatchData(priceValue: 9.0800, volumQuanti: 29),
                MatchData(priceValue: 9.0800, volumQuanti: 15),
                MatchData(priceValue: 9.0800, volumQuanti: 124),
                MatchData(priceValue: 9.0800, volumQuanti: 50),
                MatchData(priceValue: 9.0800, volumQuanti: 1),
                MatchData(priceValue: 9.0800, volumQuanti: 1),
                MatchData(priceValue: 9.0800, volumQuanti: 50)
            ]
        ),
        profitData: ProfitData(
            cashProfit: 3.14,
            cashPrice: 8.6900,
            creditProfit: 5.12,
            creditPrice: 8.5500,
            guaranteeProfit: 10.50,
            guaranteePrice: 8.3000
        ),
        bidPrice: [
            PriceData(price: 9.0800, change: -0.11),
            PriceData(price: 9.0700, change: -0.22),
            PriceData(price: 9.0600, change: -0.33),
            PriceData(price: 9.0500, change: -0.44),
            PriceData(price: 9.0400, change: -0.55),
            PriceData(price: 9.0300, change: -0.44),
            PriceData(price: 9.0200, change: -0.66),
            PriceData(price: 9.0100, change: -0.77),
            PriceData(price: 9.0000, change: -0.88),
            PriceData(price: 8.9900, change: -0.99)
        ],
        askVolume: [
            VolumeData(volume: 81),
            VolumeData(volume: 1939),
            VolumeData(volume: 2788),
            VolumeData(volume: 4620),
            VolumeData(volume: 5390),
            VolumeData(volume: 3645),
            VolumeData(volume: 3501),
            VolumeData(volume: 7549),
            VolumeData(volume: 4235),
            VolumeData(volume: 208),
        ]
    )
}
