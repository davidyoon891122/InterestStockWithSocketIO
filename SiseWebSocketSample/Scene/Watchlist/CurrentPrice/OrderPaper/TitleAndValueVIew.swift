//
//  TitleAndValueVIew.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/30.
//

import UIKit
import SnapKit

final class TitleAndValueView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        label.textColor = .lightGray
        label.text = "52 Week\nHigh"
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .medium)
        label.textColor = .label
        label.text = "19.6837"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            titleLabel,
            contentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topOffset)
            $0.leading.equalToSuperview().offset(leadingOffset)
            $0.bottom.equalToSuperview().offset(-bottomOffset)
        }
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-trailingOffset)
        }
        
        return view
    }()
    
    private var topOffset: CGFloat
    private var leadingOffset: CGFloat
    private var bottomOffset: CGFloat
    private var trailingOffset: CGFloat
    
    init(
        titleValue: String,
        contentValue: String,
        topOffset: CGFloat = 8.0,
        leadingOffset: CGFloat = 8.0,
        bottomOffset: CGFloat = 8.0,
        trailingOffset: CGFloat = 8.0
    ) {
        self.topOffset = topOffset
        self.leadingOffset = leadingOffset
        self.bottomOffset = bottomOffset
        self.trailingOffset = trailingOffset
        super.init(frame: .zero)
        titleLabel.text = titleValue
        contentLabel.text = contentValue
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(value: String) {
        contentLabel.text = value
    }
}

private extension TitleAndValueView {
    func setupViews() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TitleAndValueViewPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            TitleAndValueView(titleValue: "52 Week\nHigh", contentValue: "19.5300")
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 50.0)
    }
}
#endif
