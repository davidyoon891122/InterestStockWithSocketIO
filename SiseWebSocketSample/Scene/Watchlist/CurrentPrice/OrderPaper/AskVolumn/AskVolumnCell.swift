//
//  AskVolumnCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit
import SnapKit

final class AskVolumnCell: UICollectionViewCell {
    static let identifier = "AskVolumnCell"
    
    private lazy var askVolumnCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            AskCell.self,
            forCellWithReuseIdentifier: AskCell.identifier
        )
        
        collectionView.dataSource = self
        
        return collectionView
    }()

    func setupCell() {
        setupViews()
    }
}

extension AskVolumnCell: UICollectionViewDataSource {
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
            withReuseIdentifier: AskCell.identifier,
            for: indexPath
        ) as? AskCell else { return UICollectionViewCell() }
        
        cell.setupCell()
        
        return cell
    }
    
    
}

private extension AskVolumnCell {
    func setupViews() {
        contentView.addSubview(askVolumnCollectionView)
        
        askVolumnCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(35.0)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(350.0)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
        
        return layout
    }
}
