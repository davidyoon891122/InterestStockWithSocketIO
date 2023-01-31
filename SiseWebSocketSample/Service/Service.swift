//
//  Service.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import Foundation
import RxSwift
import Alamofire

// Request functions
final class Service {
    func requestService<T: Decodable> (
        url: URL,
        type: T.Type,
        method: HTTPMethod,
        param: [String: String],
        header: HTTPHeaders?
    ) -> Observable<T> {
        return Observable.create { emitter in
            
            AF.request(
                url,
                method: method,
                parameters: param,
                headers: header
            )
            .responseData { result in
                guard let statusCode = result.response?.statusCode,
                      let data = result.data
                else {
                    emitter.onError(NetworkError.responseError)
                    return
                }
                
                switch statusCode {
                case 200...300:
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        emitter.onNext(jsonData)
                    } catch let error {
                        print(error)
                        emitter.onError(error)
                    }
                default:
                    emitter.onError(NetworkError.responseError)
                }
            }
            return Disposables.create()
        }
    }
    
    func requestDownload(url: URL) -> Observable<URL?> {
        return Observable.create { emitter in
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("master.json")
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
                    
            AF.download(
                url,
                to: destination
            )
            .response { response in
                if let fileURL = response.fileURL {
                    debugPrint(fileURL)
                }
                emitter.onNext(response.fileURL)
            }
            
            return Disposables.create()
        }
    }
}


enum NetworkError: Error {
    case responseError
    case decondingError
}
