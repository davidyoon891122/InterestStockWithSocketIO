//
//  MatchCell.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/11.
//

import UIKit
import SnapKit

final class MatchCell: UICollectionViewCell {
    static let identifier = "MatchCell"
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .medium)
        label.textColor = .label
        label.text = "9.0500"
        
        return label
    }()
    
    private lazy var volumnLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .medium)
        label.textColor = .label
        label.text = "42,000"
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        [
            priceLabel,
            volumnLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset / 4)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset / 4)
        }
        
        volumnLabel.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        volumnLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(matchData: MatchData) {
        priceLabel.text = matchData.priceValue.fourPointStringNumber
        volumnLabel.text = "\(matchData.volumQuanti)"
    }
}

private extension MatchCell {
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MatchCellPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            MatchCell()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 30.0)
    }
}


#endif
