//
//  InformationContentViewCellViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import Foundation

protocol InformationContentViewCellViewModelInput {
    func requestStockInsights(code: String)
}

protocol InformationContentViewCellViewModelOutput {
    
}

protocol InformationContentViewCellViewModelType {
    var inputs: InformationContentViewCellViewModelInput { get }
    var outputs: InformationContentViewCellViewModelOutput { get }
}


final class InformationContentViewCellViewModel: InformationContentViewCellViewModelType, InformationContentViewCellViewModelInput, InformationContentViewCellViewModelOutput {
    var inputs: InformationContentViewCellViewModelInput { self }
    var outputs: InformationContentViewCellViewModelOutput { self }
    
    private let stockRepository = StockRepository()
    
    func requestStockInsights(code: String) {
        stockRepository.inputs.requestStockInsights(code: code)
    }
    
    
}
