//
//  MasterParser.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/31.
//

import Foundation

final class MasterParser {
    static var overseaStocks: [StockModel] = []
    
    static func parseMaster(path: URL) {
        do {
            let dataFromPath: Data = try Data(contentsOf: path)
            let stocks = try JSONDecoder().decode(MasterModel.self, from: dataFromPath)
            
            overseaStocks = stocks.stocks
            print("Did finish parse master file")
        } catch let error {
            print(error)
        }
        
        
    }
}
