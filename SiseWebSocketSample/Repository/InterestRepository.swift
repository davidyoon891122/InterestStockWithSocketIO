//
//  InterestRepository.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/08.
//

import Foundation
import RxSwift

protocol InterestRepositoryInput {
    func fetchAddingInterestCode(userId: String, code: String)
    func fetchDeletingInterestCode(userId: String, code: String)
}

protocol InterestRepositoryOutput {
    
}

protocol InterestRepositoryType {
    var inputs: InterestRepositoryInput { get }
    var outputs: InterestRepositoryOutput { get }
}

final class InterestRepository: InterestRepositoryType, InterestRepositoryInput, InterestRepositoryOutput {
    var inputs: InterestRepositoryInput { self}
    
    var outputs: InterestRepositoryOutput { self }
    
    let service = Service()
    private let disposeBag = DisposeBag()
    
    func fetchAddingInterestCode(userId: String, code: String) {
        service.requestService(
            url: URLInfo.addInterestStock.url,
            type: CommonResponseModel<InterestAddResponseModel>.self,
            method: .patch,
            param: [
                "userId": userId,
                "code": code
            ],
            encoder: .json,
            header: [:]
        )
        .debug("fetchAddingInterestCode")
        .subscribe(onNext: { result in
            print(result)
        }, onError: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
    
    func fetchDeletingInterestCode(userId: String, code: String) {
        service.requestService(
            url: URLInfo.deleteInterestStock.url,
            type: CommonResponseModel<InterestAddResponseModel>.self,
            method: .patch,
            param: [
                "userId": userId,
                "code": code
            ],
            encoder: .json,
            header: [:]
        )
        .debug("fetchAddingInterestCode")
        .subscribe(onNext: { result in
            print(result)
        }, onError: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
}
