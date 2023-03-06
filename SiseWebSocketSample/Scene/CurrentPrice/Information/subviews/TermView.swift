//
//  TermView.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TermView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Short Term Outlook"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var hideButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        button.tintColor = .gray
        
        return button
    }()
    
    private lazy var stateDescriptionLabelView = TitleValueLabelView(title: "StateDescription")
    private lazy var directionLabelView = TitleValueLabelView(title: "Direction")
    private lazy var scoreLabelView = TitleValueLabelView(title: "Score")
    private lazy var scoreDescriptionLabelView = TitleValueLabelView(title: "ScoreDescription")
    private lazy var sectorDirectionLabelView = TitleValueLabelView(title: "SectorDirection")
    private lazy var sectorScoreLabelView = TitleValueLabelView(title: "SectorScore")
    private lazy var sectorScoreDescriptionLabelView = TitleValueLabelView(title: "SectorScoreDescription")
    private lazy var indexDirectionLabelView = TitleValueLabelView(title: "IndexDirection")
    private lazy var indexScoreLabelView = TitleValueLabelView(title: "IndexScore")
    private lazy var indexScoreDescriptionLabelView = TitleValueLabelView(title: "IndexScoreDescription")
    
    private lazy var labelHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        [
            stateDescriptionLabelView,
            directionLabelView,
            scoreLabelView,
            scoreDescriptionLabelView,
            sectorDirectionLabelView,
            sectorScoreLabelView,
            sectorScoreDescriptionLabelView,
            indexDirectionLabelView,
            indexScoreLabelView,
            indexScoreDescriptionLabelView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8.0
        [
            titleLabel,
            hideButton,
            labelHStackView
        ]
            .forEach {
                view.addSubview($0)
            }
       
        let offset: CGFloat = 16.0
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        hideButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.width.height.equalTo(offset)
        }
        
        labelHStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset / 2)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    var buttonTap: ControlEvent<Void> {
        hideButton.rx.tap
    }
    
    private var disposeBag = DisposeBag()
    
    var isDisplay = true
    
    init(title:String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLayout() {
        if !isDisplay {
            hideButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            hideButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        setStackViewLayout()
    }
    
    func setShortData(shortTerm: ShortTermOutlook) {
        stateDescriptionLabelView.setValueLabel(value: shortTerm.stateDescription)
        directionLabelView.setValueLabel(value: shortTerm.direction)
        scoreLabelView.setValueLabel(value: "\(shortTerm.score)")
        scoreDescriptionLabelView.setValueLabel(value: shortTerm.scoreDescription)
        sectorScoreLabelView.setValueLabel(value: "\(shortTerm.sectorScore)")
        sectorDirectionLabelView.setValueLabel(value: shortTerm.sectorDirection)
        sectorScoreDescriptionLabelView.setValueLabel(value: shortTerm.sectorScoreDescription)
        indexDirectionLabelView.setValueLabel(value: shortTerm.indexDirection)
        indexScoreLabelView.setValueLabel(value: "\(shortTerm.indexScore)")
        indexScoreDescriptionLabelView.setValueLabel(value: shortTerm.indexScoreDescription)
    }
}

private extension TermView {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                addSubview($0)
            }
       
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setStackViewLayout() {
        let offset: CGFloat = 16.0
        if !isDisplay {
            labelHStackView.removeFromSuperview()
            titleLabel.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(offset)
                $0.leading.equalToSuperview().offset(offset)
                $0.trailing.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-offset)
            }
        } else {
            containerView.addSubview(labelHStackView)
            
            titleLabel.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(offset)
                $0.leading.equalToSuperview().offset(offset)
                $0.trailing.equalToSuperview()
            }
            
            hideButton.snp.remakeConstraints {
                $0.centerY.equalTo(titleLabel)
                $0.trailing.equalToSuperview().offset(-offset)
                $0.width.height.equalTo(offset)
            }
            
            labelHStackView.snp.remakeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(offset / 2)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
        }
    }
}
