//
//  URLInfo.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation

enum URLInfo {
    case interestStock
    case currentPriceSise
    case master
    case bigsize
    case currentPrice
    
    
    var url: URL {
        switch self {
        case .interestStock:
            let baseURL = Constants.baseURL
            return URL(string: "http://\(baseURL)/interest-list")!
            
        case .currentPriceSise:
            let baseURL = Constants.baseURL
            return URL(string: "http://\(baseURL)")!
        case .master:
            let baseURL = Constants.baseURL
            return URL(string: "http://\(baseURL)/master")!
        case .bigsize:
            let baseURL = Constants.baseURL
            return URL(string: "http://\(baseURL)/bigsize")!
        case .currentPrice:
            let baseURL = Constants.baseURL
            return URL(string: "http://\(baseURL)/current-price")!
        }
    }
}
