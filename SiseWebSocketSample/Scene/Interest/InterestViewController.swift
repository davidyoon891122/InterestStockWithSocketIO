//
//  InterestViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import UIKit
import SnapKit
import RxSwift

class InterestViewController: UIViewController {
    private lazy var currentPriceCollectionView: UICollectionView = {
        let layout = DynamicFlowLayout()
        layout.estimatedItemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 50.0
        )
        layout.minimumLineSpacing = 0
        
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
    
    private var interestStocks: [CurrentPriceModel] = [] {
        didSet {
            self.currentPriceCollectionView.reloadData()
        }
    }
    
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
        view.backgroundColor = .systemPurple
        setupViews()
        configureNavigation()
        bindViewModel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.fetchIntrestStockList()
    }
}

extension InterestViewController: UICollectionViewDataSource {
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
        
        let stock = interestStocks[indexPath.item]
        cell.setupCell(stock: stock)
        
        return cell
    }
}

extension InterestViewController: UICollectionViewDelegateFlowLayout {
    
}


private extension InterestViewController {
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
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        navigationItem.title = "Items of Interest"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
                self.requestStockListSise()
            })
            .disposed(by: disposeBag)


        viewModel.outputs.sise
            .debug("sise")
            .subscribe(onNext: { [weak self] siseModel in
                guard let self = self else { return }
                if let row = self.interestStocks.firstIndex(where: { $0.stockName == siseModel.code }) {
                    let oldModel = self.interestStocks[row]
                    let newModel = CurrentPriceModel(
                        stockName: oldModel.stockName,
                        currentPrice: siseModel.currentPrice.toFloatWithoutComma,
                        percentChange: Float(siseModel.percentChange)!,
                        prevPriceRate: Float(siseModel.prevPriceRate)!,
                        isUp: siseModel.isUp)
                    self.interestStocks[row] = newModel
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
                    title: "Error",
                    content: error.localizedDescription,
                    leftButtonTitle: nil,
                    rightButtonTitle: "Confirm",
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
                    title: "Error",
                    content: errorString,
                    leftButtonTitle: nil,
                    rightButtonTitle: "Confirm",
                    leftAction: {
                        self.dismiss(animated: true)
                    }, rightAction: {
                        self.dismiss(animated: true)
                    })
                popupViewController.modalPresentationStyle = .overFullScreen
                self.present(popupViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func didTapReloadButton() {
        viewModel.inputs.requestDisconnect()
        viewModel.inputs.openSearchViewController()
    }

    func requestStockListSise() {
        interestStocks.forEach {
            viewModel.inputs.fetchSise(code: $0.stockName)
        }
    }
}


extension String {
    var toFloatWithoutComma: Float {
        return Float(self.components(separatedBy: ",").joined()) ?? 0.0
    }
}
