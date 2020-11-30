//
//  EventsViewController.swift
//  Capstone
//
//  Created by Yessen Yermukhanbet on 9/26/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class EventsListViewController: UIViewController {
    var db: Firestore!
    var tableView = UITableView()
    var data:  [Dictionary<String, Any>] = []
    var activityView:  UIActivityIndicatorView?
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    @objc func refresh(){
        if #available(iOS 13.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
        } else {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        //self.playSound(soundFileName: "start")
    }
    func update(){
        self.data = []
        self.getEvents()
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            //self.playSound(soundFileName: "finish")
            self.refresher.endRefreshing()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refresher.isRefreshing == true{
            update()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableVIew()
        setupFirestore()
        getEvents()
        self.showActivityIndicator()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func setupTableVIew(){
        view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        tableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        setupTableViewConstraints()
        tableView.separatorColor = UIColor.black
        tableView.backgroundColor = .clear
        tableView.refreshControl  = refresher
        tableView.isScrollEnabled = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    private func setupTableViewConstraints(){
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    func setupFirestore(){
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    private func getEvents(){
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.data.append(document.data())
                }
                self.hideActivityIndicator()
                self.tableView.reloadData()
            }
        }
    }
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
        self.tableView.separatorColor = .clear
    }
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
            self.tableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}
extension EventsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell  else{fatalError("Unable to create cell") }
        cell.backgroundColor = .clear
        cell.setDetailss(name: self.data[indexPath.section]["title"] as! String, description: self.data[indexPath.section]["description"] as! String, building: self.data[indexPath.section]["building"] as! String, time: self.data[indexPath.section]["startTime"] as? String ?? "Not given", duration: self.data[indexPath.section]["duration"] as? String ?? "Not given")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
}
