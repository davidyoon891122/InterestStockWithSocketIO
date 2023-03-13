//
//  CurrentPriceViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/13.
//

import Foundation
import RxSwift
import UIKit

protocol CurrentPriceViewModelInput {
    func fetchCurrentPrice(code: String)
    func moveContentCollectionViewCell(indexPath: IndexPath)
    func selectMenuByContentIndex(indexPath: IndexPath)
    func requestSise(code: String)
    func requestDisconnect()
    func presentViewController(viewController: UIViewController)
}

protocol CurrentPriceViewModelOutput {
    var currentPricePublishSubject: PublishSubject<[CurrentPriceModel]> { get }
    var contentCellIndexPathPublishSubject: PublishSubject<IndexPath> { get }
    var menuCellIndexPathPublishSubject: PublishSubject<IndexPath> { get }
    var selectedCode: String { get }
    var sisePublishSubject: PublishSubject<SiseModel> { get }
    var presentViewControllerPublishSubject: PublishSubject<UIViewController> { get }
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
    var menuCellIndexPathPublishSubject: PublishSubject<IndexPath> = .init()
    var sisePublishSubject: PublishSubject<SiseModel> = .init()
    var presentViewControllerPublishSubject: PublishSubject<UIViewController> = .init()
    
    var selectedCode = ""
    
    func fetchCurrentPrice(code: String) {
        selectedCode = code
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
    
    func selectMenuByContentIndex(indexPath: IndexPath) {
        menuCellIndexPathPublishSubject.onNext(indexPath)
    }
    
    func requestSise(code: String) {
        SiseSocketManager.shared.requestComplete {
            SiseSocketManager.shared.socket.emit("code", code)
        }
        
        receiveSise()
        
        if SiseSocketManager.shared.socket.status == .notConnected
            || SiseSocketManager.shared.socket.status == .disconnected {
            SiseSocketManager.shared.establishConnection()
        }
    }
    
    func receiveSise() {
        SiseSocketManager.shared.socket.on("sise") { [weak self] data, ack in
            guard let self = self else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data[0], options: .prettyPrinted)
                let siseModel = try JSONDecoder().decode(SiseModel.self, from: jsonData)
                
                self.sisePublishSubject.onNext(siseModel)
            } catch {
                print(error)
            }
        }
    }
    
    func requestDisconnect() {
        SiseSocketManager.shared.socket.disconnect()
    }
    
    func presentViewController(viewController: UIViewController) {
        presentViewControllerPublishSubject.onNext(viewController)
    }
}
