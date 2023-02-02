//
//  MasterParser.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/31.
//

import Foundation

final class MasterParser {
    static var overseaStocks: [StockModel] = []
    
    static func parseMaster(path: URL) throws {
        do {
            let dataFromPath: Data = try Data(contentsOf: path)
            let stocks = try JSONDecoder().decode(MasterModel.self, from: dataFromPath)
            print(stocks)
            overseaStocks = stocks.stocks
            print("Did finish parse master file")
        } catch let error {
            throw error
        }
        
        
    }
    
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let masterPath = paths[0].appendingPathComponent("master.json")
        return masterPath
    }
}
