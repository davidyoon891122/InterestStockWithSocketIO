//
//  PopupContentView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/09.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class PopupContentView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private let separatorView = SeparatorView(
        size: 1.0,
        bgColor: .lightGray.withAlphaComponent(0.3),
        direction: .horizontal
    )
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        button.backgroundColor = .label
        
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        
        [
            leftButton,
            rightButton
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8.0
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        view.layer.shadowRadius = 1.0
        view.layer.shadowOpacity = 0.3
        
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        [
            titleLabel,
            separatorView,
            contentLabel,
            buttonHStackView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        buttonHStackView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.height.equalTo(36.0)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    var leftButtonTap: ControlEvent<Void> {
        leftButton.rx.tap
    }
    
    var rightButtonTap: ControlEvent<Void> {
        rightButton.rx.tap
    }
    
    private var disposeBag = DisposeBag()
    
    init(
        title: String,
        content: String,
        leftButtonTitle: String = "Cancel",
        rightButtonTitle: String = "Confirm"
    ) {
        super.init(frame: .zero)
        titleLabel.text = title
        contentLabel.text = content
        leftButton.setTitle(leftButtonTitle, for: .normal)
        rightButton.setTitle(rightButtonTitle, for: .normal)
        
                             
        setupViews()
    }
    
    func setShadowPath() {
        containerView.layoutIfNeeded()
        containerView.layer.shadowPath = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: containerView.layer.cornerRadius
        ).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PopupContentView {
    func setupViews() {
        addSubview(containerView)
        
        let windowWidth = UIScreen.main.bounds.width
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(windowWidth * 3 / 4)
        }
    }
}
