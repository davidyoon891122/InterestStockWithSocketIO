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
    
    func requestSise() {
        SiseSocketManager.shared.requestSise(code: "삼성전자")
    }
}


enum NetworkError: Error {
    case responseError
    case decondingError
}
