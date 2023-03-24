//
//  OrderPaperContentViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit
import SnapKit

final class OrderPaperContentViewCell: UICollectionViewCell {
    static let identifier = "OrderPaperContentViewCell"
    
    private lazy var orderPaperCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(
            AskVolumnCell.self,
            forCellWithReuseIdentifier: AskVolumnCell.identifier
        )
        
        collectionView.register(
            MatchVolumnCell.self,
            forCellWithReuseIdentifier: MatchVolumnCell.identifier
        )
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    func setupCell() {
        setupViews()
    }
}

extension OrderPaperContentViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AskVolumnCell.identifier,
                for: indexPath
            ) as? AskVolumnCell else { return UICollectionViewCell() }
            
            cell.setupCell()
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MatchVolumnCell.identifier,
                for: indexPath
            ) as? MatchVolumnCell else { return UICollectionViewCell() }
            
            cell.setupCell()
            
            return cell
        }
    }
    
    
}

private extension OrderPaperContentViewCell {
    func setupViews() {
        contentView.addSubview(orderPaperCollectionView)
        
        orderPaperCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let configure = UICollectionViewCompositionalLayoutConfiguration()
        configure.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            
            if sectionIndex == 0 {
                return self.createSection()
            } else {
                return self.createSection()
            }
        }, configuration: configure)
        
        return layout
    }
    
    func createSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(330.0)))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .estimated(330.0)),
                subitems: [item]
            )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}
            
