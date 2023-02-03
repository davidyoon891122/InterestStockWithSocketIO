//
//  SearchViewController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/02/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    private lazy var presentTopView = PresentTopView(title: "종목 검색", buttonImage: "xmark")
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            StockTableViewCell.self,
            forCellReuseIdentifier: StockTableViewCell.identifier
        )
        
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as? StockTableViewCell else { return UITableViewCell() }
        
        cell.setupCell(code: "AMZN", title: "Amazon", isSelected: false)
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    
}

private extension SearchViewController {
    func setupViews() {
        [
            presentTopView,
            searchTableView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        presentTopView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(presentTopView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bindUI() {
        presentTopView.buttonTap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
