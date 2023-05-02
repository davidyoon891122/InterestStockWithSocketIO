//
//  AskVolumeCell.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/04/11.
//

import UIKit
import SnapKit

final class AskVolumeCell: UICollectionViewCell {
    static let identifier = "AskVolumeCell"
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = .label
        label.text = "3,420"
        label.textAlignment = .left
        
        return label
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed.withAlphaComponent(0.3)
        [
            volumeLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 8.0
        volumeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(volumeData: VolumeData) {
        volumeLabel.text = "\(volumeData.volume)"
    }
}

private extension AskVolumeCell {
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
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct AskVolumeCellPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            AskVolumeCell()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 30.0)
    }
}

#endif
