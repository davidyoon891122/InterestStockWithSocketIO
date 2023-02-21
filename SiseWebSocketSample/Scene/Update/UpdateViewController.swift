//
//  UpdateViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/30.
//

import UIKit
import SnapKit
import RxSwift

final class UpdateViewController: UIViewController {
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .gray
        label.text = "0.0 %"
        
        return label
    }()
    
    private lazy var progressInnerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 4.0
        
        return view
    }()
    
    private lazy var downloadProgressView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        
        [
            progressInnerView,
            percentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 2.0
        
        progressInnerView.snp.makeConstraints {
            $0.height.equalTo(5.0)
            $0.leading.equalToSuperview().offset(4.0)
            $0.top.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
            $0.width.equalTo(0.0)
        }
        
        return view
    }()
    
    private var progressViewWidth: CGFloat = 0.0
    private var currentPercent: CGFloat = 0.0
    
    private var viewModel: UpdateViewModelType = UpdateViewModel()
    private var disposeBag = DisposeBag()
    
    private var rootViewModel: RootViewModelType
    
    init(rootViewModel: RootViewModelType) {
        self.rootViewModel = rootViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressViewWidth = UIScreen.main.bounds.width - 32.0
        viewModel.inputs.fetchDownloadMaster()
    }
}

private extension UpdateViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        [
            downloadProgressView,
            percentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 16.0
        
        downloadProgressView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        percentLabel.snp.makeConstraints {
            $0.top.equalTo(downloadProgressView.snp.bottom).offset(2.0)
            $0.trailing.equalTo(downloadProgressView)
            
        }
    }
    
    func bindViewModel() {
        viewModel.outputs.updateFinishedPublishSubject
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                if result {
                    self.dismiss(animated: false)
                    self.rootViewModel.inputs.presentInterestViewController()
                }
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.updateProgressBarPublishSubject
            .subscribe(onNext: { [weak self] isFinish, progress in
                guard let self = self else { return }
                UIView.animate(withDuration: 1.0, animations: {
                    self.percentLabel.text = String(format: "%.2f %%", progress)
                    self.progressInnerView.snp.updateConstraints{
                        $0.width.equalTo(self.progressViewWidth * (progress / 100))
                    }
                })
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.updateFailPublishSubject
            .subscribe(onNext: { [weak self] tryCount in
                guard let self = self else { return }
                
                let popupVC = PopupViewController(rightButtonTitle: "Try again(\(tryCount))",
                    leftAction: {
                        print("LeftButton has tapped")
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            exit(0)
                        })
                    
                }, rightAction: { [weak self] in
                    guard let self = self else { return }
                    print("Request fetchMaster again!")
                    self.viewModel.inputs.fetchDownloadMaster()
                })
                popupVC.modalPresentationStyle = .overFullScreen
                self.present(popupVC, animated: false)
            })
            .disposed(by: disposeBag)
        
    }
}
