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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        imageView.image = UIImage(named: "map")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
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
        scrollView.contentSize = CGSize(width: map.frame.width, height: map.frame.height)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.delegate = self
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
