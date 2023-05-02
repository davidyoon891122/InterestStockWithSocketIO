//
//  BidPriceView.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/11.
//

import UIKit
import SnapKit

final class BidPriceView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            AskPriceCell.self,
            forCellWithReuseIdentifier: AskPriceCell.identifier
        )
        
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, PriceData>!
    
    private var priceData: [PriceData]?
    
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
    
    func setDataInfo(stockInfo: StockInfoData) {
        priceData = stockInfo.bidPrice
        applySnapshot()
    }
}

extension BidPriceView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

private extension BidPriceView {
    func setupViews() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(Constants.OrderPaper.orderPaperHeight / 10)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(Constants.OrderPaper.priceViewWidth), heightDimension: .absolute(Constants.OrderPaper.orderPaperHeight)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
        
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AskPriceCell.identifier, for: indexPath) as? AskPriceCell else { return UICollectionViewCell() }
            
            cell.setupCell(priceData: item)
            
            return cell
        })
        applySnapshot()
    }
    
    func applySnapshot() {
        guard let priceData = self.priceData else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Int, PriceData>()
        snapshot.appendSections([0])
        snapshot.appendItems(priceData)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct BidPriceViewPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            BidPriceView(viewModel: MainViewModel())
        }
        .frame(width: Constants.OrderPaper.priceViewWidth, height: Constants.OrderPaper.orderPaperHeight)
    }
}

#endif
