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
        encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
        header: HTTPHeaders?
    ) -> Observable<T> {
        return Observable.create { emitter in

            AF.request(
                url,
                method: method,
                parameters: param,
                encoder: encoder,
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
    
    func requestDownload(fileName: String, url: URL) -> Observable<(URL?,Double)> {
        return Observable.create { emitter in
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(fileName)
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
                    
            AF.download(
                url,
                to: destination
            )
            .downloadProgress { progress in
                let donwloadedPercent = progress.fractionCompleted * 100
                emitter.onNext((nil, donwloadedPercent))
            }
            .response { response in
                if let fileURL = response.fileURL {
                    debugPrint(fileURL)
                }
                emitter.onNext((response.fileURL, 100.0))
            }
            
            return Disposables.create()
        }
    }
}


enum NetworkError: Error {
    case responseError
    case decondingError
}
