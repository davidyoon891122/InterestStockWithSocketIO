//
//  UpdateRepository.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/31.
//

import Foundation
import RxSwift


protocol UpdateRepositoryInput {
    func fetchDownloadMaster() -> Observable<URL>
}

protocol UpdateRepositoryOutput {
    
}

protocol UpdateRepositoryType {
    var inputs: UpdateRepositoryInput { get }
    var outputs: UpdateRepositoryOutput { get }
}


final class UpdateRepository: UpdateRepositoryType, UpdateRepositoryInput, UpdateRepositoryOutput {
    var inputs: UpdateRepositoryInput { self }
    
    var outputs: UpdateRepositoryOutput { self }
    
    private let service = Service()
    private let disposeBag = DisposeBag()
    
    func fetchDownloadMaster() -> Observable<URL> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.service.requestDownload(fileName: "master.json", url: URLInfo.master.url)
                .debug("requestDownload")
                .subscribe(onNext: { fileUrl in
                    guard let url = fileUrl else { return }
                    emitter.onNext(url)
                    
                }, onError: { error in
                    emitter.onError(error)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func fetchDownloadFiles() -> Observable<URL> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.service.requestDownload(fileName: "bigfile.zip" ,url: URLInfo.bigsize.url)
                .debug("fetchDownloadFiles")
                .subscribe(onNext: { fileUrl in
                    guard let url = fileUrl else { return }
                    emitter.onNext(url)
                    
                }, onError: { error in
                    emitter.onError(error)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    
}
