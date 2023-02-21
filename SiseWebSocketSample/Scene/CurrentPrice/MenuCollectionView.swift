//
//  MenuCollectionView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/21.
//

import UIKit
import SnapKit

final class MenuCollectionView: UIView {
    private lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let menus = ["Information", "Asking Price", "Chart", "Conclusion", "News"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return menus.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.identifier,
            for: indexPath
        ) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        
        let menu = menus[indexPath.item]
        cell.setupCell(title: menu)
        
        return cell
    }
}

extension MenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let label = UILabel()
        label.text  = menus[indexPath.item]
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.sizeToFit()
        
        return CGSize(width: label.frame.width + 16.0, height: 50.0)
    }
}

private extension MenuCollectionView {
    func setupViews() {
        [
            menuCollectionView
        ]
            .forEach {
                addSubview($0)
            }
        
        menuCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
