//
//  InterestViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import Foundation
import RxSwift

protocol InterestViewModelInput {
    func fetchIntrestStockList()
}

protocol InterestViewModelOutput {
    var currentPrices: PublishSubject<[CurrentPriceModel]> { get }
    var currentPricesError: PublishSubject<String> { get }
}

protocol InterestViewModelType {
    var inputs: InterestViewModelInput { get }
    var outputs: InterestViewModelOutput { get }
}


final class InterestViewModel: InterestViewModelType, InterestViewModelInput, InterestViewModelOutput {
    var inputs: InterestViewModelInput { self }
    var outputs: InterestViewModelOutput { self }
    
    private let repository: StockRepositoryType = StockRepository()
    private let disposeBag = DisposeBag()
    
    var currentPrices: PublishSubject<[CurrentPriceModel]> = .init()
    var currentPricesError: PublishSubject<String> = .init()
    
    func fetchIntrestStockList() {
        repository.inputs.requestStockInfo()
            .debug("fetchIntrestStockList")
            .subscribe(onNext: { [weak self] models in
                guard let self = self else { return }
                self.outputs.currentPrices.onNext(models)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.currentPricesError.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
