//
//  Constants.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation
import UIKit

enum ServerStatus {
    case dev
    case real
}

struct Constants {
    static let server: ServerStatus = .dev
    
    static let baseURL: String = server == .dev ? "127.0.0.1:3000" : "127.0.0.1:3000"
    
    enum OrderPaper {
        static let volumeViewWidth: CGFloat = (UIScreen.main.bounds.width * 2) / 7
        static let priceViewWidth: CGFloat = (UIScreen.main.bounds.width * 3) / 7
        
        static let orderPaperHeight: CGFloat = 350.0
    }
}
