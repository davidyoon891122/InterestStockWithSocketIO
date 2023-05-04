//
//  WatchlistViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import UIKit
import SnapKit
import RxSwift

class WatchlistViewController: UIViewController {
    private lazy var currentPriceCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.register(
            CurrentPriceCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrentPriceCollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
    private let viewModel: InterestViewModelType = InterestViewModel()
    private let disposeBag = DisposeBag()
    
    private var interestStocks: [CurrentPriceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        setupViews()
        configureNavigation()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.fetchIntrestStockList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear!")
        viewModel.inputs.requestDisconnect()
    }
}

extension WatchlistViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return interestStocks.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrentPriceCollectionViewCell.identifier,
            for: indexPath
        ) as? CurrentPriceCollectionViewCell else { return UICollectionViewCell() }
        
        let currentPriceModel = interestStocks[indexPath.item]
        cell.setupCell(currentPriceModel: currentPriceModel)
        
        return cell
    }
}

extension WatchlistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let code = interestStocks[indexPath.item]
        let currentPriceVC = CurrentPriceViewController(
            stockModel: StockModel(
                symbol: code.symbol,
                name: code.stockName
            )
        )
        navigationController?.pushViewController(currentPriceVC, animated: true)
    }
}


private extension WatchlistViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        [
            currentPriceCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        currentPriceCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavigation() {
        navigationItem.title = "Items of Interest".localized
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(didTapReloadButton)
        )
    }
    
    func bindViewModel() {
        viewModel.outputs.currentPrices
            .subscribe(onNext: { [weak self] currentPrices in
                guard let self = self else { return }
                self.interestStocks = currentPrices
                self.currentPriceCollectionView.reloadData()
                self.requestStockListSise()
            })
            .disposed(by: disposeBag)


        viewModel.outputs.sise
            .debug("sise")
            .subscribe(onNext: { [weak self] siseModel in
                guard let self = self else { return }
                if let row = self.interestStocks.firstIndex(where: { $0.symbol == siseModel.code }) {
                    let indexPath = IndexPath(item: row, section: 0)
                    guard let cell = self.currentPriceCollectionView.cellForItem(at: indexPath) as? CurrentPriceCollectionViewCell else { return }
                    
                    cell.updateSise(model: siseModel)
                }


            }, onError: { error in

            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.searchViewController
            .subscribe(onNext: { [weak self] searchVC in
                guard let self = self else { return }
                self.present(searchVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.outputs.errorCodePublishSubject
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                let popupViewController = PopupViewController(
                    title: "Error".localized,
                    content: error.localizedDescription,
                    leftButtonTitle: nil,
                    rightButtonTitle: "Confirm".localized,
                    leftAction: {
                        self.dismiss(animated: true)
                    }, rightAction: {
                        self.dismiss(animated: true)
                    })
                popupViewController.modalPresentationStyle = .overFullScreen
                self.present(popupViewController, animated: true)
                
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.currentPricesError
            .subscribe(onNext: { [weak self] errorString in
                guard let self = self else { return }
                let popupViewController = PopupViewController(
                    title: "Error".localized,
                    content: errorString,
                    leftButtonTitle: nil,
                    rightButtonTitle: "Confirm".localized,
                    leftAction: {
                        self.dismiss(animated: true)
                    }, rightAction: {
                        self.dismiss(animated: true)
                    })
                popupViewController.modalPresentationStyle = .overFullScreen
                self.present(popupViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.outputs.currentViewController
            .subscribe(onNext: { [weak self] stockModel in
                guard let self = self else { return }
                let currentViewController = CurrentPriceViewController(stockModel: stockModel)
                self.navigationController?.pushViewController(currentViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func didTapReloadButton() {
        viewModel.inputs.requestDisconnect()
        viewModel.inputs.openSearchViewController()
    }

    func requestStockListSise() {
        viewModel.inputs.fetchSise(interestStocks: interestStocks)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(70.0)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(70.0)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
        
        return layout
    }
}

extension String {
    var toFloatWithoutComma: Double {
        return Double(self.components(separatedBy: ",").joined()) ?? 0.0
    }
}
