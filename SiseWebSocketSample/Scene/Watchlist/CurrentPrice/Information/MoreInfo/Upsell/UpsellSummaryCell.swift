//
//  UpsellSummaryCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit
import SnapKit

final class UpsellSummaryCell: UICollectionViewCell {
    static let identifier = "UpsellSummaryCell"
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.isEditable = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        
        return textView
    }()
    
    func setupCell(content: String) {
        contentTextView.text = content
        setupViews()
    }
}

private extension UpsellSummaryCell {
    func setupViews() {
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
