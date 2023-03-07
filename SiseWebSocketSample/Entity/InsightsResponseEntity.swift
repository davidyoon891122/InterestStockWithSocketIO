//
//  InsightsResponseEntity.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import Foundation

struct InsightsResponseEntity: Decodable {
    let result: InsightsEntity?
    let message: String?
}

struct InsightsEntity: Decodable {
    let symbol: String
    let instrumentInfo: InstrumentInfo
    let companySnapshot: CompanySnapshot
    let upsell: Upsell
    let upsellSearchDD: UpsellSearchDD
    let events: [Events]
    let reports: [Reports]
    let sigDevs: [SigDevs]
    let secReports: [SecReports]
}

struct InstrumentInfo: Decodable {
    let technicalEvents: TechnicalEvents
    let keyTechnicals: KeyTechnicals
    let valuation: Valuation
}

struct TechnicalEvents: Decodable {
    let provider: String
    let sector: String
    let shortTermOutlook: ShortTermOutlook
    let intermediateTermOutlook: IntermediateTermOutlook
    let longTermOutlook: LongTermOutlook
}

struct ShortTermOutlook: Decodable {
    let stateDescription: String
    let direction: String
    let score: Int
    let scoreDescription: String
    let sectorDirection: String
    let sectorScore: Int
    let sectorScoreDescription: String
    let indexDirection: String
    let indexScore: Int
    let indexScoreDescription: String
}

struct IntermediateTermOutlook: Decodable {
    let stateDescription: String
    let direction: String
    let score: Int
    let scoreDescription: String
    let sectorDirection: String
    let sectorScore: Int
    let sectorScoreDescription: String
    let indexDirection: String
    let indexScore: Int
    let indexScoreDescription: String
}

struct LongTermOutlook: Decodable {
    let stateDescription: String
    let direction: String
    let score: Int
    let scoreDescription: String
    let sectorDirection: String
    let sectorScore: Int
    let sectorScoreDescription: String
    let indexDirection: String
    let indexScore: Int
    let indexScoreDescription: String
}

struct KeyTechnicals: Decodable {
    let provider: String
    let support: Double
    let resistance: Double
    let stopLoss: Double
}

struct Valuation: Decodable {
    let color: Double
    let description: String
    let discount: String?
    let relativeValue: String?
    let provider: String
}

struct CompanySnapshot: Decodable {
    let sectorInfo: String
    let company: Company
    let sector: Sector
}

struct Company: Decodable {
    let innovativeness: Double
    let hiring: Double?
    let sustainability: Double?
    let insiderSentiments: Double?
    let earningsReports: Double?
    let dividends: Double?
}

struct Sector: Decodable {
    let innovativeness: Double
    let hiring: Double
    let sustainability: Double
    let insiderSentiments: Double
    let earningsReports: Double
    let dividends: Double
}

struct Recommendation: Decodable {
    let targetPrice: Int
    let provider: String
    let rating: String
}

struct Upsell: Decodable {
    let msBullishSummary: [String]
    let msBearishSummary: [String]
    let companyName: String
    let msBullishBearishSummariesPublishDate: String
    let upsellReportType: String
}

struct UpsellSearchDD: Decodable {
    let researchReports: ResearchReports
}

struct ResearchReports: Decodable {
    let reportId: String
    let provider: String
    let title: String
    let reportDate: String
    let summary: String
    let investmentRating: String
}

struct Events: Decodable {
    let eventType: String
    let pricePeriod: String
    let tradingHorizon: String
    let tradeType: String
    let imageUrl: String
    let startDate: String
    let endDate: String
}

struct Reports: Decodable {
    let id: String
    let headHtml: String
    let provider: String
    let reportDate: String
    let reportTitle: String
    let reportType: String
    let targetPrice: Int?
    let targetPriceStatus: String?
    let investmentRating: String?
}

struct SigDevs: Decodable {
    let headline: String
    let date: String
}

struct SecReports: Decodable {
    let id: String
    let type: String
    let title: String
    let description: String
    let filingDate: String
    let snapshotUrl: String
    let formType: String
}
