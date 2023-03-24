//
//  MainTarbarItem.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit

enum MainTabbarItem: CaseIterable {
    case watchlist
    case chart
    case Ideas
    case news
    case settings
    
    var title: String {
        switch self {
        case .watchlist:
            return "Watchlist".localized
        case .chart:
            return "Chart".localized
        case .Ideas:
            return "Ideas".localized
        case .news:
            return "News".localized
        case .settings:
            return "Settings".localized
        }
    }
    
    var iconImage: (default: UIImage?, selected: UIImage?) {
        switch self {
        case .watchlist:
            return (
                UIImage(systemName: "star"),
                UIImage(systemName: "star.fill")
            )
        case .chart:
            return (
                UIImage(systemName: "chart.line.uptrend.xyaxis.circle"),
                UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
            )
        case .Ideas:
            return (
                UIImage(systemName: "bubble.left.and.bubble.right"),
                UIImage(systemName: "bubble.left.and.bubble.right.fill")
            )
        case .news:
            return (
                UIImage(systemName: "newspaper"),
                UIImage(systemName: "newspaper.fill")
            )
        case .settings:
            return (
                UIImage(systemName: "gearshape"),
                UIImage(systemName: "gearshape.fill")
            )
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .watchlist:
            return UINavigationController(rootViewController: WatchlistViewController())
        case .chart:
            return UIViewController()
        case .Ideas:
            return UIViewController()
        case .news:
            return UIViewController()
        case .settings:
            return UIViewController()
        }
    }
}
