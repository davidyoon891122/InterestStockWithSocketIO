//
//  SearchViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import Foundation

protocol SearchViewModelInput {
    
}

protocol SearchViewModelOutput {
    
}

protocol SearchViewModelTypes {
    var inputs: SearchViewModelInput { get }
    var outputs: SearchViewModelOutput { get }
}

final class SearchViewModel: SearchViewModelTypes, SearchViewModelInput, SearchViewModelOutput {
    var inputs: SearchViewModelInput { self }
    
    var outputs: SearchViewModelOutput { self }
    
    
}
