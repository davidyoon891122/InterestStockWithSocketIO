//
//  InformationTechnicalViewCell.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class InformationTechnicalViewCell: UICollectionViewCell {
    static let identifier = "InformationTechnicalViewCell"
    
    private lazy var providerLabelView = TitleValueLabelView(title: "Provider")
    private lazy var sectorLabelView = TitleValueLabelView(title: "Sector")
    
    private lazy var shortTermView = TermView(title: "Short Term Outlook")
    private lazy var intermediateTermView = TermView(title: "Intermediate Term Outlook")
    private lazy var longTermView = TermView(title: "Long Term Outlook")
    
    private lazy var keyTechnicalsView = KeyTechnicalsView()
    private lazy var valuationView = ValuationView()
    
    private lazy var companySnapshotView = SnapshotView(title: "Company")
    private lazy var sectorSnapshotView = SnapshotView(title: "Sector")
    
    private lazy var recommendView = RecommendationView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            providerLabelView,
            sectorLabelView,
            shortTermView,
            intermediateTermView,
            longTermView,
            keyTechnicalsView,
            valuationView,
            companySnapshotView,
            sectorSnapshotView,
            recommendView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        providerLabelView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        sectorLabelView.snp.makeConstraints {
            $0.top.equalTo(providerLabelView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        shortTermView.snp.makeConstraints {
            $0.top.equalTo(sectorLabelView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        intermediateTermView.snp.makeConstraints {
            $0.top.equalTo(shortTermView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        longTermView.snp.makeConstraints {
            $0.top.equalTo(intermediateTermView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        keyTechnicalsView.snp.makeConstraints {
            $0.top.equalTo(longTermView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        valuationView.snp.makeConstraints {
            $0.top.equalTo(keyTechnicalsView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        companySnapshotView.snp.makeConstraints {
            $0.top.equalTo(valuationView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        sectorSnapshotView.snp.makeConstraints {
            $0.top.equalTo(companySnapshotView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        recommendView.snp.makeConstraints {
            $0.top.equalTo(sectorSnapshotView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.high)
        }
        
        return view
    }()
    
    private var disposeBag = DisposeBag()
    
    private var viewModel: InformationContentViewCellViewModelType?
    
    func setupCell(viewModel: InformationContentViewCellViewModelType, insight: InsightsResponseEntity?) {
        self.viewModel = viewModel
        providerLabelView.setValueLabel(value: "Trading Central")
        sectorLabelView.setValueLabel(value: "Technology")
        
        if let insight = insight {
            setupData(insight: insight)
        }
        setupViews()
        bindUI()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return layoutAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

private extension InformationTechnicalViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindUI() {
        shortTermView.buttonTap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let viewModel = self.viewModel
                else { return }
                self.shortTermView.isDisplay = !self.shortTermView.isDisplay
                self.shortTermView.updateLayout()
                viewModel.inputs.reloadCollectionViewLayout()
            })
            .disposed(by: disposeBag)
        
        intermediateTermView.buttonTap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let viewModel = self.viewModel
                else { return }
                self.intermediateTermView.isDisplay = !self.intermediateTermView.isDisplay
                self.intermediateTermView.updateLayout()
                viewModel.inputs.reloadCollectionViewLayout()
            })
            .disposed(by: disposeBag)
        
        longTermView.buttonTap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let viewModel = self.viewModel
                else { return }
                self.longTermView.isDisplay = !self.longTermView.isDisplay
                self.longTermView.updateLayout()
                viewModel.inputs.reloadCollectionViewLayout()
            })
            .disposed(by: disposeBag)
    }
    
    func setupData(insight: InsightsResponseEntity) {
        if let shortTerm = insight.result?.instrumentInfo.technicalEvents.shortTermOutlook {
            shortTermView.setShortData(shortTerm: shortTerm)
        }
    }
}
