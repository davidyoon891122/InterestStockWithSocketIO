//
//  MatchInfoData.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/07.
//

import Foundation

struct MatchInfoStrengthData: Hashable {
    var matchStrength: Double
}

struct MatchData: Hashable {
    var uuid = UUID()
    var priceValue: Double
    var volumQuanti: Int
}

struct MatchInfoData: Hashable {
    let strengthData: MatchInfoStrengthData
    let matchData: [MatchData]
}


extension MatchInfoStrengthData {
    static let strengthItem = MatchInfoStrengthData(matchStrength: 130.50)
}

extension MatchData {
    static let matchItem = [
            MatchData(priceValue: 9.4500, volumQuanti: 320),
            MatchData(priceValue: 9.4000, volumQuanti: 320),
            MatchData(priceValue: 9.3500, volumQuanti: 320),
            MatchData(priceValue: 9.3000, volumQuanti: 320),
            MatchData(priceValue: 9.2500, volumQuanti: 320),
            MatchData(priceValue: 9.2000, volumQuanti: 320),
            MatchData(priceValue: 9.1500, volumQuanti: 320),
            MatchData(priceValue: 9.1000, volumQuanti: 320),
            MatchData(priceValue: 9.0500, volumQuanti: 320),
            MatchData(priceValue: 9.0000, volumQuanti: 320),
            MatchData(priceValue: 8.9500, volumQuanti: 320),
            MatchData(priceValue: 8.9000, volumQuanti: 320),
            MatchData(priceValue: 8.8500, volumQuanti: 320),
            MatchData(priceValue: 8.8000, volumQuanti: 320),
            MatchData(priceValue: 8.7500, volumQuanti: 320)
    ]
}

extension MatchInfoData {
    static let item = MatchInfoData(strengthData: MatchInfoStrengthData.strengthItem, matchData: MatchData.matchItem)
}

