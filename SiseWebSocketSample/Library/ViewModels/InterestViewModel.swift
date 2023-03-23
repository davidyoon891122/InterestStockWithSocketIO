//
//  InterestViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import Foundation
import RxSwift
import UIKit

protocol InterestViewModelInput {
    func fetchIntrestStockList()
    func fetchSise(interestStocks: [CurrentPriceModel])
    func openSearchViewController()
    func requestDisconnect()
    func fetchCurrentPrice(stocks: [InterestStockModel])
}

protocol InterestViewModelOutput {
    var currentPrices: PublishSubject<[CurrentPriceModel]> { get }
    var currentPricesError: PublishSubject<String> { get }
    var sise: PublishSubject<SiseModel> { get }
    var searchViewController: PublishSubject<UIViewController> { get }
    var interestList: PublishSubject<[StockModel]> { get }
    var errorCodePublishSubject: PublishSubject<Error> { get }
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
    var searchViewController: PublishSubject<UIViewController> = .init()
    var interestList: PublishSubject<[StockModel]> = .init()
    var errorCodePublishSubject: PublishSubject<Error> = .init()
    
    func fetchIntrestStockList() {
        repository.inputs.requestInterestList(userID: "davidyoon")
            .debug("requestInterestList")
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                InterestStockManager.shared.setInteresetStocks(stocks: result)
                if result.isEmpty {
                    self.outputs.currentPrices.onNext([])
                    return
                }
                self.fetchCurrentPrice(stocks: result)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.errorCodePublishSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchCurrentPrice(stocks: [InterestStockModel]) {
        
        var requestString = ""
        stocks.forEach {
            requestString += $0.code + "|"
        }
        debugPrint(requestString)
        
        repository.inputs.requestStockInfo(stocks: requestString)
            .debug("fetchCurrentPrice requestStockInfo")
            .subscribe(onNext: { [weak self] models in
                guard let self = self else { return }
                self.outputs.currentPrices.onNext(models)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.currentPricesError.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchSise(interestStocks: [CurrentPriceModel]) {
        SiseSocketManager.shared.requestComplete {
            interestStocks.forEach {
                SiseSocketManager.shared.socket.emit("code", $0.symbol)
            }
        }
        receiveSise()
        if SiseSocketManager.shared.socket.status == .notConnected
            || SiseSocketManager.shared.socket.status == .disconnected {
            connectSocket()
        }
    }
    
    func openSearchViewController() {
        let searchViewController = UINavigationController(rootViewController: SearchViewController(viewModel: self))
        searchViewController.modalPresentationStyle = .fullScreen
        
        outputs.searchViewController.onNext(searchViewController)
    }
    
    func requestDisconnect() {
        SiseSocketManager.shared.closeConnection()
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
