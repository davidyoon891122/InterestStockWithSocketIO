//
//  RightInfoView.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/30.
//

import UIKit
import SnapKit

enum RightInfoSection: String, CaseIterable, Hashable {
    case main
}


enum RightInfoItem: Hashable {
    case first(FirstInfoData)
    case second(SecondInfoData)
}

final class RightInfoView: UIView {
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.numberOfPages = 2
        
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            FirstInfoCell.self,
            forCellWithReuseIdentifier: FirstInfoCell.identifier
        )
        collectionView.register(
            SecondInfoCell.self,
            forCellWithReuseIdentifier: SecondInfoCell.identifier
        )
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<RightInfoSection, RightInfoItem>!
    
    private var firstInfoData: FirstInfoData?
    private var secondInfoData: SecondInfoData?
    
    private var viewModel: MainViewModelType
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfoData(stockInfo: StockInfoData) {
        self.firstInfoData = stockInfo.firstInfoData
        self.secondInfoData = stockInfo.secondInfoData
        applySnapshot()
    }
}

private extension RightInfoView {
    func setupViews() {
        [
            collectionView,
            pageControl
        ]
            .forEach {
                addSubview($0)
            }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(pageControl.snp.top)
        }
        
        pageControl.snp.makeConstraints {
            $0.height.equalTo(10.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(Constants.OrderPaper.volumeViewWidth), heightDimension: .fractionalHeight(1)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .paging
            
            section.visibleItemsInvalidationHandler =  { item, offset, env in
                let index = Int((offset.x / env.container.contentSize.width).rounded(.up))
                self.pageControl.currentPage = index
                
            }
            
            return section
            
        })
        
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<RightInfoSection, RightInfoItem> (collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            switch item {
                
            case .first(let firstItem):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstInfoCell.identifier, for: indexPath) as? FirstInfoCell else { return UICollectionViewCell() }
                cell.setupCell(firstInfo: firstItem)
                return cell
            case .second(let secondItem):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondInfoCell.identifier, for: indexPath) as? SecondInfoCell else { return UICollectionViewCell() }
                
                cell.setInfoData(stockInfo: secondItem)
                return cell
            }
            
        })
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<RightInfoSection, RightInfoItem>()
        snapshot.appendSections([.main])
        guard let firstInfoData = self.firstInfoData,
              let secondInfoData = self.secondInfoData else { return }
                
        snapshot.appendItems([.first(firstInfoData), .second(secondInfoData)])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct RightInfoViewPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            RightInfoView(viewModel: MainViewModel())
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 300.0)
    }
}
#endif

