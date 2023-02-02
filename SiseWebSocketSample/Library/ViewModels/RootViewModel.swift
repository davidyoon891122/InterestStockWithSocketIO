//
//  RootViewModel.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/02.
//

import Foundation
import RxSwift
import UIKit

protocol RootViewModelInput {
    func presentUpdateViewController()
    func presentInterestViewController()
}

protocol RootViewModelOutput {
    var updateViewController: PublishSubject<UIViewController> { get }
    var interestViewController: PublishSubject<UIViewController> { get }
}

protocol RootViewModelType {
    var inputs: RootViewModelInput { get }
    var outputs: RootViewModelOutput { get }
}

final class RootViewModel: RootViewModelType, RootViewModelInput, RootViewModelOutput {
    var inputs: RootViewModelInput { self }
    var outputs: RootViewModelOutput { self }
    
    var updateViewController: PublishSubject<UIViewController> = .init()
    var interestViewController: PublishSubject<UIViewController> = .init()
    
    func presentUpdateViewController() {
        let updateViewController = UpdateViewController(rootViewModel: self)
        outputs.updateViewController.onNext(updateViewController)
    }
    
    
    func presentInterestViewController() {
        let interestViewController = InterestViewController(rootViewModel: self)
        outputs.interestViewController.onNext(interestViewController)
    }
    
    
}
