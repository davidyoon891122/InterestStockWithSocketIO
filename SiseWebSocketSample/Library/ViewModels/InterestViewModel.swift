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
    func fetchSise(code: String)
}

protocol InterestViewModelOutput {
    var currentPrices: PublishSubject<[CurrentPriceModel]> { get }
    var currentPricesError: PublishSubject<String> { get }
    var sise: PublishSubject<SiseModel> { get }
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
    var sise: PublishSubject<SiseModel> = .init()
    
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
    
    func fetchSise(code: String) {
        SiseSocketManager.shared.requestComplete {
            SiseSocketManager.shared.socket.emit("code", code)
        }

        receiveSise()
        if SiseSocketManager.shared.socket.status == .notConnected {
            connectSocket()
        }
    }

    private func connectSocket() {
        SiseSocketManager.shared.establishConnection()
    }

    private func receiveSise() {
        SiseSocketManager.shared.socket.on("sise") { [weak self] data, ack in
            guard let self = self else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data[0], options: .prettyPrinted)
                let siseModel = try JSONDecoder().decode(SiseModel.self, from: jsonData)

                self.outputs.sise.onNext(siseModel)
            } catch {
                print(error)
            }
        }
    }
}
