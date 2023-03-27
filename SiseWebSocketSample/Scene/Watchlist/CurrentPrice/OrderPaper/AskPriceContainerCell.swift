//
//  AskPriceContainerCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/27.
//

import UIKit
import SnapKit

final class AskPriceContainerCell: UICollectionViewCell {
    static let identifier = "AskPriceContainerCell"
    
    private lazy var askPriceCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            AskPriceCell.self,
            forCellWithReuseIdentifier: AskPriceCell.identifier
        )
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    func setupCell() {
       setupViews()
    }
}

extension AskPriceContainerCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AskPriceCell.identifier,
            for: indexPath
        ) as? AskPriceCell else { return UICollectionViewCell() }
        
        cell.setupCell()
        
        return cell
    }
}

private extension AskPriceContainerCell {
    func setupViews() {
        [
            askPriceCollectionView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        askPriceCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(33.0)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(330.0)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
        
        return layout
    }
}
