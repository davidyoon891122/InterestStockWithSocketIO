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
    var updateProgressBarPublishSubject: PublishSubject<(Bool, Double)> { get }
}

protocol UpdateViewModelType {
    var inputs: UpdateViewModelInput { get }
    var outputs: UpdateViewModelOutput { get }
}

final class UpdateViewModel: UpdateViewModelType, UpdateViewModelInput, UpdateViewModelOutput {
    var inputs: UpdateViewModelInput { self }
    var outputs: UpdateViewModelOutput { self }
    
    var updateFinishedPublishSubject: PublishSubject<Bool> = .init()
    var updateProgressBarPublishSubject: PublishSubject<(Bool, Double)> = .init()
    
    private let repository = UpdateRepository()
    private let disposeBag = DisposeBag()
    
    
    func fetchDownloadMaster() {
        repository.fetchDownloadMaster()
            .debug("fetchDownloadMaster")
            .subscribe(onNext: { url, progress in
                DispatchQueue.global().sync { [weak self] in
                    guard let self = self else { return }
                    do {
                        if let url = url {
                            try MasterParser.parseMaster(path: url)
                        }
                    } catch {
                        self.updateFinishedPublishSubject.onNext(false)
                    }
                    if url != nil {
                        self.updateFinishedPublishSubject.onNext(true)
                    }
                    self.updateProgressBarPublishSubject.onNext((false,progress))
                }
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
    }
    
    
    func fetchDownloadFiles() {
        repository.fetchDownloadFiles()
            .subscribe(onNext: { [weak self] url, progress in
                guard let self = self else { return }
                if url != nil {
                    self.updateFinishedPublishSubject.onNext(true)
                }
                self.updateProgressBarPublishSubject.onNext((false, progress))
            })
            .disposed(by: disposeBag)
    }
}
