//
//  MainTabBarViewController.swift
//  Capstone
//
//  Created by Yessen Yermukhanbet on 9/26/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class MainTabBarViewController: UIViewController {
    var tabBar = UITabBarController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabBar.view)
        setupTabBar()
    }
    
    let eventsImage = UIImage(systemName: "pencil.and.ellipsis.rectangle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
    let settingsImage = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
    
    private func setupTabBar(){
        let dashboardViewController = UINavigationController(rootViewController: DashboardViewController())
        dashboardViewController.title = "dashboard"
        dashboardViewController.tabBarItem.image = eventsImage
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        settingsViewController.title = "settings"
        settingsViewController.tabBarItem.image = settingsImage
        self.tabBar.viewControllers = [dashboardViewController,settingsViewController]
        self.tabBar.tabBar.backgroundColor = .white
        self.tabBar.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tabBar.tintColor = .red
    }
}
