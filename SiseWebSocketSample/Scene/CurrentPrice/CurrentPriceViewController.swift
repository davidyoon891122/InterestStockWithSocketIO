//
//  CurrentPriceViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/13.
//

import UIKit
import SnapKit
import RxSwift

final class CurrentPriceViewController: UIViewController {
    private var code: CurrentPriceModel
    
    private let viewModel: CurrentPriceViewModelType = CurrentPriceViewModel()
    
    private let disposeBag = DisposeBag()
    private lazy var topInfoView = TopInfoView()
    
    init(code: CurrentPriceModel) {
        self.code = code
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
        bindViewModel()
        viewModel.inputs.fetchCurrentPrice(code: code.symbol)
    }
}

private extension CurrentPriceViewController {
    func configureNavigation() {
        navigationItem.title = "\(code.stockName)"
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [
            topInfoView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        topInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.outputs.currentPricePublishSubject
            .subscribe(onNext: { [weak self] currentPrice in
                guard let self = self else { return }
                self.topInfoView.setName(value: currentPrice[0].stockName)
                self.topInfoView.setCode(value: currentPrice[0].symbol)
                self.topInfoView.setCurrentPrice(value: "\(currentPrice[0].currentPrice)")
                self.topInfoView.setMargetChange(value: "\(currentPrice[0].prevPriceRate)")
                self.topInfoView.setMargetChangePercent(value: "\(currentPrice[0].percentChange)")
                self.topInfoView.setPriceLabelColor(isUp: currentPrice[0].isUp)
            })
            .disposed(by: disposeBag)
    }
}
