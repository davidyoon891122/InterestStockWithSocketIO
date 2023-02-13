//
//  StockRepository.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation
import RxSwift

protocol StockRepositoryInput {
    func requestStockInfo(stocks: String) -> Observable<[CurrentPriceModel]>
    func requestInterestList(userID: String) -> Observable<[InterestStockModel]>
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
    
    func requestStockInfo(stocks: String) -> Observable<[CurrentPriceModel]>{
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.service.requestService(
                url: URLInfo.currentPrice.url,
                type: CurrentPriceResponseEntity.self,
                method: .get,
                param: [
                    "codes": stocks
                ],
                header: [:]
            )
            .debug("StockRepository requestStockInfo")
            .subscribe(onNext: { response in
                let models = response.result.map {
                    CurrentPriceModel(
                        stockName: $0.displayName ?? $0.longName,
                        currentPrice: $0.regularMarketPrice,
                        percentChange: round($0.regularMarketChangePercent * 100) / 100.0 ,
                        prevPriceRate: round($0.regularMarketChange * 10000) / 10000.0,
                        isUp: $0.regularMarketChangePercent > 0 ? true : false
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
    
    func requestInterestList(userID: String) -> Observable<[InterestStockModel]> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.service.requestService(
                url: URLInfo.interestStock.url,
                type: InterestListResponseEntity.self,
                method: .get,
                param: [
                    "userId": userID
                ],
                header: [:]
            )
            .subscribe(onNext: { result in
                emitter.onNext(result.stocks.map { InterestStockModel(code: $0.code) })
            }, onError: { error in
                emitter.onError(error)
            })
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        
    }
}
