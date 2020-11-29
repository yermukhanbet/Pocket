//
//  MainEventsViewController.swift
//  Capstone
//
//  Created by Yessen Yermukhanbet on 10/3/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import Parchment

class MainEventsViewController: UIViewController {
    let viewControllers = [EventsListViewController(),UIViewController(), UIViewController(), UIViewController()]
    let itemNames = ["All", "CS", "BA", "CE"]
    override func viewDidLoad() {
        super.viewDidLoad()
        createParchment()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.hideNavigationBar(animated: true)
    }
    private func createParchment(){
        let pagingViewController = PagingViewController()
        addChild(pagingViewController)
        pagingViewController.dataSource = self
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        pagingViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pagingViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        pagingViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        pagingViewController.menuItemSize = .fixed(width: self.view.frame.width/3, height: 40)
        pagingViewController.indicatorOptions = .visible(height: 1, zIndex: Int.max, spacing: .init(top: 0, left: 5, bottom: 0, right: 5), insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        pagingViewController.selectedTextColor = .systemGray
        pagingViewController.indicatorColor  = .systemGray
        pagingViewController.select(index: 1)
            pagingViewController.font =  UIFont.systemFont(ofSize: 12, weight: .light)
            pagingViewController.selectedFont = UIFont.systemFont(ofSize: 14, weight: .light)
    }
}
//Data source for paging view controller
extension MainEventsViewController:PagingViewControllerDataSource{
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return viewControllers.count
    }
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let viewController = viewControllers[index]
        viewController.title = itemNames[index]
        return viewController
    }
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: itemNames[index])
    }
}
//Sizedelegate for the pagingviewcontroller
extension MainEventsViewController: PagingViewControllerSizeDelegate{
    func pagingViewController(_: PagingViewController, widthForPagingItem pagingItem: PagingItem, isSelected: Bool) -> CGFloat {
        return self.view.frame.width
    }
}
