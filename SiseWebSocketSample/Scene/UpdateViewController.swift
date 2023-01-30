//
//  UpdateViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/30.
//

import UIKit
import SnapKit

final class UpdateViewController: UIViewController {
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .gray
        label.text = "0.0 %"
        
        return label
    }()
    
    private lazy var progressInnerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 4.0
        
        return view
    }()
    
    private lazy var downloadProgressView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        
        [
            progressInnerView,
            percentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 2.0
        
        progressInnerView.snp.makeConstraints {
            $0.height.equalTo(5.0)
            $0.leading.equalToSuperview().offset(4.0)
            $0.top.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
            $0.width.equalTo(0.0)
        }
        
        return view
    }()
    
    private var progressViewWidth: CGFloat = 0.0
    private var timer: Timer?
    private var currentPercent: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressViewWidth = UIScreen.main.bounds.width - 32.0
        print("progress Width: \(progressViewWidth)")
        activateProgress()
        
    }
}

private extension UpdateViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        [
            downloadProgressView,
            percentLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 16.0
        
        downloadProgressView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        percentLabel.snp.makeConstraints {
            $0.top.equalTo(downloadProgressView.snp.bottom).offset(2.0)
            $0.trailing.equalTo(downloadProgressView)
            
        }
    }
    
    func activateProgress() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(increaseProgress),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc
    func increaseProgress() {
        currentPercent = currentPercent + progressViewWidth / 10.0
        
        var percentText = String(format: "%.2f %%", ((self.currentPercent * 100) / self.progressViewWidth - 8 ))
        
        if currentPercent >= (progressViewWidth - 8) {
            timer?.invalidate()
            currentPercent = progressViewWidth - 8
            percentText = "100.0 %"
        }
        
        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.progressInnerView.snp.updateConstraints{
                $0.width.equalTo(self.currentPercent)
            }
            
            self.percentLabel.text = percentText
        }, completion: nil)
    }
}
