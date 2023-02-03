//
//  StockTableViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import UIKit
import SnapKit

final class StockTableViewCell: UITableViewCell {
    static let identifier = "StockTableViewCell"
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .label
        
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
        button.setImage(UIImage(systemName: "star.fill"), for: .highlighted)
        
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
            $0.leading.equalToSuperview().offset(offset)
            $0.centerY.equalTo(nameLabel)
        }
        
        codeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(codeLabel.snp.trailing).offset(offset)
            $0.centerY.equalTo(addImageButton)
        }
        
        addImageButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset / 2)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(addImageButton.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset / 2)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview()
        }
        
        
        
        return view
    }()
    
    func setupCell(
        code: String,
        title: String,
        isSelected: Bool
    ) {
        setupViews()
    }
}

private extension StockTableViewCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
