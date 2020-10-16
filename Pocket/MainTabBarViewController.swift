//
//  MainTabBarViewController.swift
//  Capstone
//
//  Created by Yessen Yermukhanbet on 9/26/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class MainTabBarViewController: UIViewController {
    var navBar = UITabBarController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBar.view)
        setupTabBar()
    }
    
    let eventsImage = UIImage(systemName: "person.3.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
    let mapImage = UIImage(systemName: "map.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
    let settingsImage = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
    
    private func setupTabBar(){
        let eventsViewController = UINavigationController(rootViewController: MainEventsViewController())
        eventsViewController.title = "events"
        eventsViewController.tabBarItem.image = eventsImage
        let mapViewController = UINavigationController(rootViewController: MapViewController())
        mapViewController.title = "map"
        mapViewController.tabBarItem.image = mapImage
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        settingsViewController.title = "settings"
        settingsViewController.tabBarItem.image = settingsImage
        self.navBar.viewControllers = [eventsViewController, mapViewController,settingsViewController]
        self.navBar.tabBar.barTintColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        self.navBar.tabBar.tintColor = .white
    }
}
