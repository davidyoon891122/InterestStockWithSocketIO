//
//  ContentCollectionViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/22.
//

import Foundation
import UIKit

final class ContentCollectionViewCell: UICollectionViewCell {
    static let identifier = "ContentCollectionViewCell"
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    func setupCell(color: UIColor) {
        containerView.backgroundColor = color
        setupViews()
    }
}

private extension ContentCollectionViewCell {
    func setupViews() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
