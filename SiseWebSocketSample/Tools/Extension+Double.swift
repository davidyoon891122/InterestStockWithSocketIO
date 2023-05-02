//
//  Extension+Double.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/14.
//

import Foundation

extension Double {
    var fourPointStringNumber: String {
        return String(format: "%.4f %", self)
    }
    
    var twoPointStringNumber: String {
        return String(format: "%.2f %", self)
    }
    
    var twoPointStringNumberWithSign: String {
        if self >= 0 {
            return String(format: "%.2f %", self)
        } else {
            return String(format: "-%.2f %", self)
        }
    }
}
