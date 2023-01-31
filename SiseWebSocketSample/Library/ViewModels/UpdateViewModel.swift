//
//  UpdateViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/31.
//

import Foundation
import RxSwift

protocol UpdateViewModelInput {
    func fetchDownloadMaster()
}

protocol UpdateViewModelOutput {
    
}

protocol UpdateViewModelType {
    var inputs: UpdateViewModelInput { get }
    var outputs: UpdateViewModelOutput { get }
}

final class UpdateViewModel: UpdateViewModelType, UpdateViewModelInput, UpdateViewModelOutput {
    var inputs: UpdateViewModelInput { self }
    var outputs: UpdateViewModelOutput { self }
    
    private let repository = UpdateRepository()
    private let disposeBag = DisposeBag()
    
    
    func fetchDownloadMaster() {
        repository.fetchDownloadMaster()
            .debug("fetchDownloadMaster")
            .subscribe(onNext: { url in
                MasterParser.parseMaster(path: url)
                print("master: \(MasterParser.overseaStocks)")
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
    }
}
