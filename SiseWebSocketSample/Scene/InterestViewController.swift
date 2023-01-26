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
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 50.0)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        setupViews()
        configureNavigation()
        bindViewModel()
        
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
            image: UIImage(systemName: "arrow.clockwise"),
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
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func didTapReloadButton() {
        viewModel.inputs.fetchIntrestStockList()
    }
}
