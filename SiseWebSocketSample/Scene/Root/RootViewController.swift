//
//  RootViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RootViewController: UIViewController {
    private var viewModel: RootViewModelType = RootViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var isFirst: Bool = true
    
    private lazy var presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirst {
            isFirst = false
            viewModel.inputs.presentUpdateViewController()
        }
    }
}

private extension RootViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    func bindViewModel() {
        viewModel.outputs.updateViewController
            .subscribe(onNext: { [weak self] updateVC in
                guard let self = self else { return }
                updateVC.modalPresentationStyle = .fullScreen
                self.present(updateVC, animated: false)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.outputs.interestViewController
            .subscribe(onNext: { [weak self] interestVC in
                guard let self = self else { return }
                let mainTabbarController = MainTabbarController()
                mainTabbarController.modalPresentationStyle = .fullScreen
                self.present(mainTabbarController, animated: false)
            })
            .disposed(by: disposeBag)
    }
}
