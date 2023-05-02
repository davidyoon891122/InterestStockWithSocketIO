//
//  MatchCell.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/31.
//

import UIKit
import SnapKit

final class MatchContainerCell: UICollectionViewCell {
    static let identifier = "MatchContainerCell"
    
    private let titleView = MatchStrengthTitleView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createlayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            MatchCell.self,
            forCellWithReuseIdentifier: MatchCell.identifier
        )
        
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    
    private var datasource: UICollectionViewDiffableDataSource<Int, MatchData>!
    
    private var matchData: [MatchData]?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfoData(matchInfoData: MatchInfoData) {
        matchData = matchInfoData.matchData
        applySnapshot()
    }
}

private extension MatchContainerCell {
    func setupView() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(collectionView)
        [
            titleView,
            collectionView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func createlayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/15)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
            
        })
        
        return layout
    }
    
    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Int, MatchData>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCell.identifier, for: indexPath) as? MatchCell else { return UICollectionViewCell() }
            
            cell.setupCell(matchData: item)
            return cell
        })
        
        applySnapshot()
        
    }
    
    func applySnapshot() {
        guard let matchData = self.matchData else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Int, MatchData>()
        snapshot.appendSections([0])
        snapshot.appendItems(matchData)
        datasource.apply(snapshot, animatingDifferences: true)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MatchContainerCellPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
             MatchContainerCell()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 300.0)
    }
}


#endif
