//
//  OrderPaperContentViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit
import SnapKit
import RxSwift

final class OrderPaperContentViewCell: UICollectionViewCell {
    static let identifier = "OrderPaperContentViewCell"
    
    private let scrollView = UIScrollView()
    
    private let containerView = UIView()
    
    private lazy var orderPaperView = OrderPaperView(viewModel: viewModel)
    
    private lazy var scrollTestView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        orderPaperView.backgroundColor = .systemBackground
        
        [
            orderPaperView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private var viewModel: MainViewModelType = MainViewModel()
    
    private var disposeBag = DisposeBag()
    
    func setupCell() {
        setupViews()
        bindViewModel()
        
        viewModel.inputs.requestStockInfo(code: "Apple")
    }
}

private extension OrderPaperContentViewCell {
    func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.outputs.stockInfoPublishSubject
            .subscribe(onNext: { [weak self] stockInfo in
                guard let self = self else { return }
                self.orderPaperView.setStockInfoData(stockInfo: stockInfo)
            })
            .disposed(by: disposeBag)
    }
}
            
