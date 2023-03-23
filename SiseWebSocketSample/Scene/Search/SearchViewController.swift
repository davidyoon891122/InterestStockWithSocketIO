//
//  SearchViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    private lazy var presentTopView = PresentTopView(title: "종목 검색", buttonImage: "xmark")
    
    private lazy var searchCollectionView: UICollectionView = {
        let layout = createLayout()
        
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(
            StockCollectionViewCell.self,
            forCellWithReuseIdentifier: StockCollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
    private var disposeBag = DisposeBag()
    
    private var stocks: [StockModel] = [] {
        didSet {
            self.searchCollectionView.reloadData()
        }
    }
    
    private var currentPage = 0
    
    private let viewModel: SearchViewModelType = SearchViewModel()
    
    private var interestViewModel: InterestViewModelType
    
    init(viewModel: InterestViewModelType) {
        interestViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        bindViewModel()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.requestStocks(page: currentPage)
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            let currentRow = indexPath.row
            let itemsPerPage = 100
            let expectedRowModules = itemsPerPage - 20
            let currentPageForExpectedRow = expectedRowModules / itemsPerPage
            
            guard currentRow % itemsPerPage == expectedRowModules,
                  currentRow / itemsPerPage == currentPageForExpectedRow + currentPage else {
                continue
            }
            
            currentPage += 1
            viewModel.inputs.requestStocks(page: currentPage)
            
        }
    }
    
    
}


extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return stocks.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StockCollectionViewCell.identifier,
            for: indexPath
        ) as? StockCollectionViewCell else {
            return UICollectionViewCell()
        }
        let stock = stocks[indexPath.item]
        
        cell.setupCell(stock: stock, viewModel: viewModel)
        
        return cell
    }
}

private extension SearchViewController {
    func setupViews() {
        [
            presentTopView,
            searchCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        presentTopView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(presentTopView.snp.bottom)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview()
        }
    }
    
    func bindUI() {
        presentTopView.buttonTap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    self.interestViewModel.inputs.fetchIntrestStockList()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewModel.outputs.stockModels
            .subscribe(onNext: { [weak self] stockModels in
                guard let self = self else { return }
                self.stocks = stockModels
            })
            .disposed(by: disposeBag)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100.0)
            ))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100.0)
            ), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
        
        return layout
    }
}
