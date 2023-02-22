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
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
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
    
    private lazy var separatorView = SeparatorView(
        size: 2.0,
        bgColor: .lightGray.withAlphaComponent(0.5),
        direction: .horizontal
    )
    
    private let menus = ["Information", "AskingPrice", "Chart", "Conclusion", "News"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
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
        
        return CGSize(width: label.frame.width + 16.0, height: collectionView.frame.height)
    }
}

private extension MenuCollectionView {
    func setupViews() {
        [
            menuCollectionView,
            separatorView
        ]
            .forEach {
                addSubview($0)
            }
        
        menuCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(menuCollectionView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
