//
//  Extension+String.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, value: "", comment: "")
    }
}
