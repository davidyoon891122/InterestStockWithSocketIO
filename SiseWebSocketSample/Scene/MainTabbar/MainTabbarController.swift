//
//  MainTabbarController.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/03/24.
//

import UIKit


final class MainTabbarController: UITabBarController {
    private lazy var tabbarViewController: [UIViewController] = MainTabbarItem.allCases.map {
        let viewController = $0.viewController
        viewController.tabBarItem = UITabBarItem(title: $0.title, image: $0.iconImage.default, selectedImage: $0.iconImage.selected)
        
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = tabbarViewController
    }
}
