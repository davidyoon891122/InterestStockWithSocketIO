//
//  ContentCollectionView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/22.
//

import UIKit
import SnapKit
import RxSwift

final class ContentCollectionView: UIView {
    private lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = . horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            ContentCollectionViewCell.self,
            forCellWithReuseIdentifier: ContentCollectionViewCell.identifier
        )
        
        collectionView.register(
            InformationContentViewCell.self,
            forCellWithReuseIdentifier: InformationContentViewCell.identifier
        )
        
        collectionView.register(
            NewsContentViewCell.self,
            forCellWithReuseIdentifier: NewsContentViewCell.identifier
        )
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(contentCollectionView)
        view.backgroundColor = .systemBackground
        contentCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return view
    }()
    
    private let menus: [String]
    private let currentPriceViewModel: CurrentPriceViewModelType
    
    private let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue]
    
    private var disposeBag = DisposeBag()
    
    
    
    init(menus: [String], currentPriceViewModel: CurrentPriceViewModelType) {
        self.menus = menus
        self.currentPriceViewModel = currentPriceViewModel
        super.init(frame: .zero)
        setupViews()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentCollectionView: UICollectionViewDataSource {
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
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InformationContentViewCell.identifier,
                for: indexPath
            ) as? InformationContentViewCell else { return UICollectionViewCell() }
            
            cell.setupCell(currentViewModel: currentPriceViewModel)
            return cell
            
        } else if indexPath.item == 4 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewsContentViewCell.identifier,
                for: indexPath
            ) as? NewsContentViewCell else { return UICollectionViewCell() }
            
            cell.setupCell()
            return cell
        } else  {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentCollectionViewCell.identifier,
                for: indexPath
            ) as? ContentCollectionViewCell else { return UICollectionViewCell() }
            
            let color = colors[indexPath.item]
            cell.setupCell(color: color)
            return cell
        }
    }
}

extension ContentCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.bounds.origin.x / scrollView.frame.width)
        
        let indexPath = IndexPath(item: index, section: 0)
        currentPriceViewModel.inputs.selectMenuByContentIndex(indexPath: indexPath)
        
    }
}

private extension ContentCollectionView {
    func setupViews() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        currentPriceViewModel.outputs.contentCellIndexPathPublishSubject
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.contentCollectionView.scrollToItem(
                    at: indexPath,
                    at: .centeredHorizontally,
                    animated: false
                )
            })
            .disposed(by: disposeBag)
    }
}


