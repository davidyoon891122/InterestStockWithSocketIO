//
//  InformationContentViewCellViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import Foundation
import RxSwift

protocol InformationContentViewCellViewModelInput {
    func requestStockInsights(code: String)
    func reloadCollectionViewLayout()
}

protocol InformationContentViewCellViewModelOutput {
    var reloadPublishSubject: PublishSubject<Void> { get }
}

protocol InformationContentViewCellViewModelType {
    var inputs: InformationContentViewCellViewModelInput { get }
    var outputs: InformationContentViewCellViewModelOutput { get }
}


final class InformationContentViewCellViewModel: InformationContentViewCellViewModelType, InformationContentViewCellViewModelInput, InformationContentViewCellViewModelOutput {
    var inputs: InformationContentViewCellViewModelInput { self }
    var outputs: InformationContentViewCellViewModelOutput { self }
    
    var reloadPublishSubject: PublishSubject<Void> = .init()
    
    private let stockRepository = StockRepository()
    
    func requestStockInsights(code: String) {
        stockRepository.inputs.requestStockInsights(code: code)
    }
    
    func reloadCollectionViewLayout() {
        reloadPublishSubject.onNext(())
    }
}
