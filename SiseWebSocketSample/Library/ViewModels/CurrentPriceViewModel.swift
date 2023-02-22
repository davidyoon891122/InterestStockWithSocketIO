//
//  CurrentPriceViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/13.
//

import Foundation
import RxSwift

protocol CurrentPriceViewModelInput {
    func fetchCurrentPrice(code: String)
    func moveContentCollectionViewCell(indexPath: IndexPath)
}

protocol CurrentPriceViewModelOutput {
    var currentPricePublishSubject: PublishSubject<[CurrentPriceModel]> { get }
    var contentCellIndexPathPublishSubject: PublishSubject<IndexPath> { get }
}

protocol CurrentPriceViewModelType {
    var inputs: CurrentPriceViewModelInput { get }
    var outputs: CurrentPriceViewModelOutput { get }
}


final class CurrentPriceViewModel: CurrentPriceViewModelType, CurrentPriceViewModelInput, CurrentPriceViewModelOutput {
    var inputs: CurrentPriceViewModelInput { self }
    
    var outputs: CurrentPriceViewModelOutput { self }
    
    private let stockRepository = StockRepository()
    private var disposeBag = DisposeBag()
    
    var currentPricePublishSubject: PublishSubject<[CurrentPriceModel]> = .init()
    var contentCellIndexPathPublishSubject: PublishSubject<IndexPath> = .init()
    
    func fetchCurrentPrice(code: String) {
        stockRepository.inputs.requestStockInfo(stocks: code)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.currentPricePublishSubject.onNext(result)
            })
            .disposed(by: disposeBag)
    }
    
    func moveContentCollectionViewCell(indexPath: IndexPath) {
        contentCellIndexPathPublishSubject.onNext(indexPath)
    }
    
}
