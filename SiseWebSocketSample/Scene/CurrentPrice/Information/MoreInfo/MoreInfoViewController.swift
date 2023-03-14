//
//  MoreInfoViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit
import SnapKit

final class MoreInfoViewController: UIViewController {
    private let draggableView = DraggableView()
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = DynamicFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            UpsellCollectionViewCell.self,
            forCellWithReuseIdentifier: UpsellCollectionViewCell.identifier
        )
        
        collectionView.register(
            ReportCollectionViewCell.self,
            forCellWithReuseIdentifier: ReportCollectionViewCell.identifier
        )
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private var insights: InsightsResponseEntity?
    
    init(insights: InsightsResponseEntity) {
        self.insights = insights
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
}

extension MoreInfoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UpsellCollectionViewCell.identifier,
                for: indexPath
            ) as? UpsellCollectionViewCell else { return UICollectionViewCell() }
            
            if let insights = insights {
                cell.setupCell(insights: insights)
            }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReportCollectionViewCell.identifier,
                for: indexPath
            ) as? ReportCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCell()
            return cell
        }
    }
    
    
}

private extension MoreInfoViewController {
    func setupViews() {
        [
            draggableView,
            mainCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        draggableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(draggableView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
