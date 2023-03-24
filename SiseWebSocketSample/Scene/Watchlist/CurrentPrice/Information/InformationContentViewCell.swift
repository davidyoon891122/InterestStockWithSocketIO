//
//  InformationContentViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/22.
//

import UIKit
import SnapKit
import RxSwift

final class InformationContentViewCell: UICollectionViewCell {
    static let identifier = "InformationContentViewCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = DynamicFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        
        collectionView.register(
            InformationTechnicalViewCell.self,
            forCellWithReuseIdentifier: InformationTechnicalViewCell.identifier
        )
        
        return collectionView
    }()
    
    private let viewModel: InformationContentViewCellViewModelType = InformationContentViewCellViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var insightResponseEntity: InsightsResponseEntity?
    
    private var currentPriceViewModel: CurrentPriceViewModelType?
    
    func setupCell(currentViewModel: CurrentPriceViewModelType) {
        self.currentPriceViewModel = currentViewModel
        setupViews()
        bindViewModel()
        viewModel.inputs.requestStockInsights(code: currentViewModel.outputs.selectedCode)
    }
}

extension InformationContentViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InformationTechnicalViewCell.identifier,
                for: indexPath
            ) as? InformationTechnicalViewCell else { return UICollectionViewCell() }
            
            cell.setupCell(viewModel: viewModel, insight: insightResponseEntity)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

private extension InformationContentViewCell {
    func setupViews() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.outputs.reloadPublishSubject
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.stockInsightsPublishSubject
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.insightResponseEntity = result
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        
        viewModel.outputs.moreInforViewControllerPublishSubjecte
            .subscribe(onNext: { [weak self] moreInfoVC in
                guard let self = self,
                      let currentVM = self.currentPriceViewModel
                else { return }
                currentVM.inputs.presentViewController(viewController: UINavigationController(rootViewController: moreInfoVC))
            })
            .disposed(by: disposeBag)
    }
}

