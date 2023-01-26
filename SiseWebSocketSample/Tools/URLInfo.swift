//
//  URLInfo.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation

enum URLInfo {
    case interestStock
    
    
    var url: URL {
        switch self {
        case .interestStock:
            let baseURL = Constants.baseURL
            return URL(string: "http://\(baseURL)/interest-list")!
        }
    }
}
