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
    private var timer: Timer?
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
        print("progress Width: \(progressViewWidth)")
        activateProgress()
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
    
    func activateProgress() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(increaseProgress),
            userInfo: nil,
            repeats: true
        )
    }
    
    func bindViewModel() {
        viewModel.outputs.updateFinishedPublishSubject
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                if result {
                    self.dismiss(animated: false)
                    self.rootViewModel.inputs.presentInterestViewController()
                }
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
        
    }
    
    @objc
    func increaseProgress() {
        currentPercent = currentPercent + progressViewWidth / 10.0
        
        var percentText = String(format: "%.2f %%", ((self.currentPercent * 100) / self.progressViewWidth - 8 ))
        
        if currentPercent >= (progressViewWidth - 8) {
            timer?.invalidate()
            currentPercent = progressViewWidth - 8
            percentText = "100.0 %"
        }
        
        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.progressInnerView.snp.updateConstraints{
                $0.width.equalTo(self.currentPercent)
            }
            
            self.percentLabel.text = percentText
        }, completion: nil)
    }
}
