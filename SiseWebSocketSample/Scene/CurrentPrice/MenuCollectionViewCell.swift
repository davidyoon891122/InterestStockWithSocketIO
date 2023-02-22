//
//  MenuCollectionViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/21.
//

import UIKit
import SnapKit

final class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var selectUnderBar: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        
        view.isHidden = true
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            titleLabel,
            selectUnderBar
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 16.0
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectUnderBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(2.0)
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    func setupCell(title: String) {
        titleLabel.text = title
        setupViews()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectUnderBar.isHidden = false
            } else {
                selectUnderBar.isHidden = true
            }
        }
    }
}

private extension MenuCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        let offset: CGFloat = 8.0
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
    }
}


