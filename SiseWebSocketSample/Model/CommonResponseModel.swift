//
//  CommonResponseModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/08.
//

import Foundation

struct CommonResponseModel<T: Decodable>: Decodable {
    let result: T?
    let message: String
}
