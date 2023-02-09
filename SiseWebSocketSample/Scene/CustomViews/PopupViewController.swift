//
//  PopupViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/09.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class PopupViewController: UIViewController {
    
    private lazy var popupContentView: PopupContentView = {
        let popupView = PopupContentView(
            title: "Popup Test",
            content: "This is a popup view test, Please do not use default popupView!!🤨",
            leftButtonTitle: "Cancel",
            rightButtonTitle: "Confirm"
        )
        
        popupView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        popupView.isHidden = true
        
        return popupView
    }()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(
            withDuration: 1.0,
            delay: 1.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.0,
            options: .curveEaseInOut,
            animations: {
                self.popupContentView.transform = .identity
                self.popupContentView.isHidden = false
            },
            completion: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

private extension PopupViewController {
    func setupViews() {
        [
            popupContentView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        
        popupContentView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bindUI() {
        popupContentView.leftButtonTap
            .asDriver()
            .drive(onNext: {
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        popupContentView.rightButtonTap
            .asDriver()
            .drive(onNext: {
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
    }
}
