//
//  InformationContentViewCellViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import Foundation
import RxSwift
import UIKit

protocol InformationContentViewCellViewModelInput {
    func requestStockInsights(code: String)
    func reloadCollectionViewLayout()
    func presentMoreInfoViewController()
}

protocol InformationContentViewCellViewModelOutput {
    var reloadPublishSubject: PublishSubject<Void> { get }
    var stockInsightsPublishSubject: PublishSubject<InsightsResponseEntity> { get }
    var moreInforViewControllerPublishSubjecte: PublishSubject<UIViewController> { get }
}

protocol InformationContentViewCellViewModelType {
    var inputs: InformationContentViewCellViewModelInput { get }
    var outputs: InformationContentViewCellViewModelOutput { get }
}


final class InformationContentViewCellViewModel: InformationContentViewCellViewModelType, InformationContentViewCellViewModelInput, InformationContentViewCellViewModelOutput {
    var inputs: InformationContentViewCellViewModelInput { self }
    var outputs: InformationContentViewCellViewModelOutput { self }
    
    var reloadPublishSubject: PublishSubject<Void> = .init()
    var stockInsightsPublishSubject: PublishSubject<InsightsResponseEntity> = .init()
    var moreInforViewControllerPublishSubjecte: PublishSubject<UIViewController> = .init()
    
    private let stockRepository = StockRepository()
    private let disposeBag = DisposeBag()
    
    private var insights: InsightsResponseEntity?
    
    func requestStockInsights(code: String) {
        stockRepository.inputs.requestStockInsights(code: code)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.insights = response
                self.stockInsightsPublishSubject.onNext(response)
            },onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func reloadCollectionViewLayout() {
        reloadPublishSubject.onNext(())
    }
    
    func presentMoreInfoViewController() {
        guard let insights = insights else {
            return
        }
        
        moreInforViewControllerPublishSubjecte.onNext(MoreInfoViewController(insights: insights))
    }
}
