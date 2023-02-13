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
    private var disposeBag = DisposeBag()
    
    private var leftAction: () -> ()?
    private var rightAction: () -> ()?
    
    private var popupContentView: PopupContentView
    
    init(
        title: String? = nil,
        content: String? = nil,
        leftButtonTitle: String? = "Cancel",
        rightButtonTitle: String? = "Confirm",
        leftAction: @escaping () -> (),
        rightAction: @escaping () -> ()
    ) {
        popupContentView = PopupContentView(
            title: title ?? "Update Failed",
            content: content ?? "Download master files has failed, Please check your network status!🤨",
            leftButtonTitle: leftButtonTitle ?? "Exit",
            rightButtonTitle: rightButtonTitle ?? "Try again"
        )
        self.leftAction = leftAction
        self.rightAction = rightAction
        super.init(nibName: nil, bundle: nil)
        
        popupContentView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        popupContentView.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            usingSpringWithDamping: 0.5,
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
    
    deinit {
        debugPrint("deinit")
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
        
        popupContentView.setShadowPath()
    }
    
    func bindUI() {
        popupContentView.leftButtonTap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.leftAction()
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        popupContentView.rightButtonTap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.rightAction()
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
    }
}
