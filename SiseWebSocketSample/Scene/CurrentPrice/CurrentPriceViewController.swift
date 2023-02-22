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
    private lazy var topInfoView = TopInfoView()
    private lazy var menuCollectionView = MenuCollectionView()
    private lazy var contentCollectionView = ContentCollectionView(menus: menus)
    
    private var code: CurrentPriceModel
    
    private let viewModel: CurrentPriceViewModelType = CurrentPriceViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let menus = ["Information", "AskingPrice", "Chart", "Conclusion", "News"]
    
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
        navigationController?.navigationItem.backButtonTitle = ""
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [
            topInfoView,
            menuCollectionView,
            contentCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        topInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        menuCollectionView.snp.makeConstraints {
            $0.top.equalTo(topInfoView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50.0)
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(menuCollectionView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
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
