//
//  StockTableViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class StockTableViewCell: UITableViewCell {
    static let identifier = "StockTableViewCell"
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.tintColor = .label
        
        button.isUserInteractionEnabled = true
        button.isSelected = false
        return button
    }()
    
    private let separatorView = SeparatorView(
        size: 1.0,
        bgColor: .lightGray.withAlphaComponent(0.3),
        direction: .horizontal
    )
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            codeLabel,
            nameLabel,
            addImageButton,
            separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        codeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.greaterThanOrEqualTo(50.0)
            $0.centerY.equalTo(nameLabel)
        }
        
        codeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(codeLabel.snp.trailing).offset(offset)
            $0.centerY.equalTo(addImageButton)
        }
        
        addImageButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset / 2)
            $0.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(addImageButton.snp.bottom).offset(offset / 2)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    private var disposeBag = DisposeBag()
    private var viewModel: SearchViewModelType?
    
    func setupCell(
        code: String,
        title: String,
        isSelected: Bool?,
        viewModel: SearchViewModelType
    ) {
        self.viewModel = viewModel
        nameLabel.text = title
        codeLabel.text = code
        if let isSelected = isSelected {
            addImageButton.isSelected = isSelected
        } else {
            addImageButton.isSelected = false
        }
        setupViews()
        bindUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

private extension StockTableViewCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindUI() {
        addImageButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let viewModel = self.viewModel
                else { return }
                self.addImageButton.isSelected = !self.addImageButton.isSelected
                
                
                if self.addImageButton.isSelected {
                    let interestStock = InterestStockModel(code: self.codeLabel.text!)
                    viewModel.inputs.requestAddStockToList(stock: interestStock)
                }
            })
            .disposed(by: disposeBag)
    }
}
