//
//  VolumeData.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/29.
//

import Foundation

class VolumeData: Hashable {
    var id = UUID()
    var volume: Int = 0
    
    init(volume: Int) {
        self.volume = volume
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: VolumeData, rhs: VolumeData) -> Bool {
        lhs.id == rhs.id
    }
}

extension VolumeData {
    static let allItem = [
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210),
        VolumeData(volume: 3210)
    ]
}
