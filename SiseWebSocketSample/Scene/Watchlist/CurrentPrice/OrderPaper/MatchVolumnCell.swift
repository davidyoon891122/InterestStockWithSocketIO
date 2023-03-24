//
//  MatchVolumnCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit
import SnapKit

final class MatchVolumnCell: UICollectionViewCell {
    static let identifier = "MatchVolumnCell"
    
    private lazy var matchRateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .medium)
        label.textColor = .label
        label.text = "Matched\nRate"
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var matchRateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .medium)
        label.textColor = .label
        label.text = "141.57%"
        
        return label
    }()
    
    private lazy var matchCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            MatchCell.self,
            forCellWithReuseIdentifier: MatchCell.identifier
        )
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            matchRateTitleLabel,
            matchRateLabel,
            matchCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 8.0
        matchRateTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalTo(matchRateLabel.snp.leading).offset(-offset)
        }
        
        matchRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(matchRateTitleLabel)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        matchRateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        matchCollectionView.snp.makeConstraints {
            $0.top.equalTo(matchRateTitleLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    
    func setupCell() {
        setupViews()
    }
}

extension MatchVolumnCell: UICollectionViewDataSource {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCell.identifier, for: indexPath) as? MatchCell else { return UICollectionViewCell() }
        
        cell.setupCell()
        
        return cell
    }
    
    
}

private extension MatchVolumnCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20.0)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
        
        return layout
    }
}
