//
//  InformationContentViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/22.
//

import UIKit
import SnapKit

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
            InformationCollectionViewCell.self,
            forCellWithReuseIdentifier: InformationCollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
    private let viewModel: InformationContentViewCellViewModelType = InformationContentViewCellViewModel()
    
    func setupCell() {
        setupViews()
        viewModel.inputs.requestStockInsights(code: "AAPL")
    }
}

extension InformationContentViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 7
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InformationCollectionViewCell.identifier,
            for: indexPath
        ) as? InformationCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setupCell()
        return cell
    }
    
    
}

private extension InformationContentViewCell {
    func setupViews() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

