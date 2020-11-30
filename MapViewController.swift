//
//  MapViewController.swift
//  Capstone
//
//  Created by Yessen Yermukhanbet on 9/26/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIScrollViewDelegate {
    lazy var map: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 200, y: 0, width: 1000, height: 1000))
        imageView.image = UIImage(named: "map")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    lazy var unionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(showUnionInfo), for: .touchUpInside)
        button.backgroundColor = .blue
        button.layer.cornerRadius  = 25
        button.frame = CGRect(x: 330, y: 730, width: 50, height: 50)
        return button
    }()
    lazy var gwangettoButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(gwangInfo), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = .blue
        button.frame = CGRect(x: 390, y: 320, width: 50, height: 50)
        return button
    }()
    @objc func showUnionInfo(){
        let vc = MapDetailViewController()
        self.present(vc, animated: true, completion: nil)
    }
    @objc func gwangInfo(){
        let vc = MapDetailViewController()
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
        setScroll()
        // Do any additional setup after loading the view.
    }
    func setScroll(){
        scrollView.backgroundColor = .white
        scrollView.addSubview(map)
        scrollView.contentSize = CGSize(width: map.frame.width + 200, height: map.frame.height)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.delegate = self
        scrollView.addSubview(unionButton)
        scrollView.addSubview(gwangettoButton)
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
}
