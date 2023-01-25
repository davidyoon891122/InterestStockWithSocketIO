//
//  InterestViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/25.
//

import UIKit
import SnapKit

class InterestViewController: UIViewController {
    private lazy var currentPriceCollectionView: UICollectionView = {
        let layout = DynamicFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 50.0)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.register(
            CurrentPriceCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrentPriceCollectionViewCell.identifier
        )
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        setupViews()
        configureNavigation()
    }
}

extension InterestViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 50
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrentPriceCollectionViewCell.identifier,
            for: indexPath
        ) as? CurrentPriceCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setupCell()
        
        return cell
    }
}

extension InterestViewController: UICollectionViewDelegateFlowLayout {
    
}


private extension InterestViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        [
            currentPriceCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        currentPriceCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        navigationItem.title = "Items of Interest"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
