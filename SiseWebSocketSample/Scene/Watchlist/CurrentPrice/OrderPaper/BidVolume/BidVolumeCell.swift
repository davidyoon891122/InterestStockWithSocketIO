//
//  BidVolumeCell.swift
//  OrderPaperSample
//
//  Created by jiwon Yoon on 2023/03/29.
//

import UIKit
import SnapKit

final class BidVolumeCell: UICollectionViewCell {
    static let identifier = "BidVolumeCell"
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = .label
        label.text = "3,420"
        label.textAlignment = .right
        
        return label
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.3)
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
    
    func setupCell(volume: VolumeData) {
        volumeLabel.text = "\(volume.volume)"
    }
}

private extension BidVolumeCell {
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

struct BidVolumeCellPreview: PreviewProvider {
    static var previews: some View {
        UIView.UIViewPreview {
            BidVolumeCell()
        }
        .frame(width: Constants.OrderPaper.volumeViewWidth, height: 30.0)
    }
}

#endif
