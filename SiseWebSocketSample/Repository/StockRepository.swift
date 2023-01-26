//
//  StockRepository.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation
import RxSwift

protocol StockRepositoryInput {
    func requestStockInfo() -> Observable<[CurrentPriceModel]>
}

protocol StockRepositoryOutput {
    
}

protocol StockRepositoryType {
    var inputs: StockRepositoryInput { get }
    var outputs: StockRepositoryOutput { get }
}

final class StockRepository: StockRepositoryType, StockRepositoryInput, StockRepositoryOutput {
    var inputs: StockRepositoryInput { self }
    var outputs: StockRepositoryOutput { self }
    
    private let service = Service()
    private let disposeBag = DisposeBag()
    
    func requestStockInfo() -> Observable<[CurrentPriceModel]>{
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.service.requestService(
                url: URLInfo.interestStock.url,
                type: [InterestStockEntity].self,
                method: .get,
                param: [:],
                header: [:]
            )
            .debug("requestStockInfo")
            .subscribe(onNext: { result in
                let models = result.map {
                    CurrentPriceModel(
                        stockName: $0.stockName,
                        currentPrice: $0.currentPrice,
                        percentChange: $0.percentChange,
                        prevPriceRate: $0.prevPriceRate,
                        isUp: $0.isUp
                    )
                }
                emitter.onNext(models)
            }, onError: { error in
                emitter.onError(error)
            })
            .disposed(by: self.disposeBag)
            return Disposables.create()
        }
        
    }
}
