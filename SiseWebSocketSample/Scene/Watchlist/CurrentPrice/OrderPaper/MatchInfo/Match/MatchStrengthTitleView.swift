//
//  MatchStrengthTitleView.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/11.
//

import UIKit
import SnapKit

final class MatchStrengthTitleView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        label.textColor = .gray
        label.text = "Match\nStrength"
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .medium)
        label.textColor = .label
        label.text = "130.50%"
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
       
        [
            titleLabel,
            contentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        
        let offset: CGFloat = 8.0
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset / 2)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset / 2)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(offset)
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        contentLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MatchStrengthTitleView {
    func setupViews() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MatchStrengthCellPreviews: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            MatchStrengthTitleView()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 50.0)
    }
}



#endif
