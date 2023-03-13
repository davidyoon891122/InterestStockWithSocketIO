//
//  UpsellSummaryView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit
import SnapKit

final class UpsellSummaryView: UIView {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 10.0
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            UpsellSummaryCell.self,
            forCellWithReuseIdentifier: UpsellSummaryCell.identifier
        )
        
        collectionView.backgroundColor = .secondarySystemBackground
        
        return collectionView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8.0
        
        [
            iconImageView,
            titleLabel,
            collectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.width.height.equalTo(20.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, UpsellData>! = nil
    
    private var upsellData: [UpsellData] = []
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = .red
        setupViews()
        configureDatasource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var insights: InsightsResponseEntity? = nil
    
    func setUpsellData(insights: InsightsResponseEntity) {
        guard let bullishSummary = insights.result?.upsell.msBullishSummary else { return }
        self.upsellData = bullishSummary.map {
            UpsellData(content: $0)
        }
        
        applySnapshot(animatingDifferences: true)
    }
}

private extension UpsellSummaryView {
    func setupViews() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let containGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [item])

            let section = NSCollectionLayoutSection(group: containGroup)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }, configuration: config)
        return layout
    }
    
    func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Int, UpsellData>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: UpsellData) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpsellSummaryCell.identifier, for: indexPath) as? UpsellSummaryCell
            cell?.setupCell(content: item.content)
            return cell
        }
        
        applySnapshot(animatingDifferences: true)
    }
    
    func applySnapshot(animatingDifferences: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UpsellData>()
        snapshot.appendSections([0])
        snapshot.appendItems(upsellData)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

