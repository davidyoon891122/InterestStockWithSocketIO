//
//  ReportView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/13.
//

import UIKit
import SnapKit

final class ReportView: UIView {
    private lazy var reportCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            ReportCell.self,
            forCellWithReuseIdentifier: ReportCell.identifier
        )
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, ReportData>! = nil
    
    private var reportData: [ReportData] = ReportData.allReport
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureDatasource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ReportView {
    func setupViews() {
        [
            reportCollectionView
        ]
            .forEach {
                addSubview($0)
            }
        
        reportCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(33 * 7 + 50)
        }
        
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            let containGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: containGroup)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }, configuration: config)
        
        return layout
    }
    
    func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Int, ReportData>(collectionView: reportCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: ReportData) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportCell.identifier, for: indexPath) as? ReportCell
            
            cell?.setupCell()
            
            return cell
        }
        
        applySnapshot(animatingDifferences: true)
    }
    
    func applySnapshot(animatingDifferences: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ReportData>()
        snapshot.appendSections([0])
        snapshot.appendItems(reportData)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
