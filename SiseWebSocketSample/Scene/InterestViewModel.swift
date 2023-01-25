//
//  InterestViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import Foundation

protocol InterestViewModelInput {
    
}

protocol InterestViewModelOutput {
    
}

protocol InterestViewModelType {
    var inputs: InterestViewModelInput { get }
    var outputs: InterestViewModelOutput { get }
}


final class InterestViewModel: InterestViewModelType, InterestViewModelInput, InterestViewModelOutput {
    var inputs: InterestViewModelInput { self }
    var outputs: InterestViewModelOutput { self }
}
