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
        
        view.alpha = 0
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
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.selectUnderBar.alpha = self.isSelected ? 1 : 0
                }, completion: nil
            )
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


