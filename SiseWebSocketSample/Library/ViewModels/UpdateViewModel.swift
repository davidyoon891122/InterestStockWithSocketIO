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
    func fetchDownloadFiles()
}

protocol UpdateViewModelOutput {
    var updateFinishedPublishSubject: PublishSubject<Bool> { get }
}

protocol UpdateViewModelType {
    var inputs: UpdateViewModelInput { get }
    var outputs: UpdateViewModelOutput { get }
}

final class UpdateViewModel: UpdateViewModelType, UpdateViewModelInput, UpdateViewModelOutput {
    var inputs: UpdateViewModelInput { self }
    var outputs: UpdateViewModelOutput { self }
    
    var updateFinishedPublishSubject: PublishSubject<Bool> = .init()
    
    private let repository = UpdateRepository()
    private let disposeBag = DisposeBag()
    
    
    func fetchDownloadMaster() {
        repository.fetchDownloadMaster()
            .debug("fetchDownloadMaster")
            .subscribe(onNext: { url in
                DispatchQueue.global().sync { [weak self] in
                    guard let self = self else { return }
                    do {
                        try MasterParser.parseMaster(path: url)
                    } catch {
                        self.updateFinishedPublishSubject.onNext(false)
                    }
                    self.updateFinishedPublishSubject.onNext(true)
                }
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
    }
    
    
    func fetchDownloadFiles() {
        repository.fetchDownloadFiles()
            .debug("fetchDownloadFiles")
            .subscribe(onNext: { url in
                print(url)
                
            })
            .disposed(by: disposeBag)
    }
}
