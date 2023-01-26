//
//  Constants.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation

enum ServerStatus {
    case dev
    case real
}

struct Constants {
    static let server: ServerStatus = .dev
    
    static let baseURL: String = server == .dev ? "127.0.0.1:3000" : "127.0.0.1:3000"
}
