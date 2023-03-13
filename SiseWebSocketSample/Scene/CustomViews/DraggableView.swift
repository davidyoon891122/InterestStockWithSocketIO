//
//  DraggableView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/13.
//

import UIKit

final class DraggableView: UIView {
    private lazy var dragView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 3.0
        
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

private extension DraggableView {
    func setupViews() {
        addSubview(dragView)
        
        let offset: CGFloat = 2.0
        
        let width = UIScreen.main.bounds.width / 10
        
        dragView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(4.0)
            $0.bottom.equalToSuperview().offset(-offset)
        }
    }
}
