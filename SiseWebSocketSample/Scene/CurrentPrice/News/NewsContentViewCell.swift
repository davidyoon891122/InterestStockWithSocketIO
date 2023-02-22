//
//  NewsContentViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/22.
//

import UIKit
import SnapKit

final class NewsContentViewCell: UICollectionViewCell {
    static let identifier = "NewsCollectionViewCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = DynamicFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        collectionView.dataSource = self
        collectionView.register(
            NewsContentCollectionViewCell.self,
            forCellWithReuseIdentifier: NewsContentCollectionViewCell.identifier
        )
        
        
        return collectionView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            collectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

extension NewsContentViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsContentCollectionViewCell.identifier, for: indexPath) as? NewsContentCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell()
        
        return cell
    }
}

private extension NewsContentViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
