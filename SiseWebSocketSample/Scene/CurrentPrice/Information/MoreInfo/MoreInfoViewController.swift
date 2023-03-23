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
        let layout = createLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            UpsellCollectionViewCell.self,
            forCellWithReuseIdentifier: UpsellCollectionViewCell.identifier
        )
        
        collectionView.register(
            ReportHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ReportHeaderView.identifier
        )
        
        collectionView.register(
            ReportCell.self,
            forCellWithReuseIdentifier: ReportCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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

extension MoreInfoViewController: UICollectionViewDelegateFlowLayout {

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
            guard let reports = insights?.result?.reports else { return 0}
            return reports.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
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
                withReuseIdentifier: ReportCell.identifier,
                for: indexPath
            ) as? ReportCell else { return UICollectionViewCell() }
            cell.setupCell()
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ReportHeaderView.identifier,
            for: indexPath
        ) as? ReportHeaderView else { return UICollectionReusableView() }
        
        headerView.setupCell()
        
        return headerView
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
    
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(300.0)
                )
            )
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(300.0)
                ),
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            if sectionIndex == 1 {
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(50.0)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                section.boundarySupplementaryItems = [sectionHeader]
            }
            
            return section
        })
        
        return layout
    }
}
