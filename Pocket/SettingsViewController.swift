//
//  SettingsViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/17/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let tableView = UITableView()
    let sections: [String] = ["My profile", "My events","Preferences"]
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "default_profile")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.borderWidth = 0.1
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let profileName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Please log in"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
    }
    private func setupNavigationController(){
        navigationController?.navigationBar.barTintColor = .gray
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        self.view.addSubview(tableView)
        setTableVewConstraints()
        setHeaderView()
    }
    private func setTableVewConstraints(){
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    private func setHeaderView(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        tableView.tableHeaderView = headerView
        //Profile image in header view
        headerView.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 50).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //Profile name in header view
        headerView.addSubview(profileName)
        profileName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        profileName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 20).isActive = true
        profileName.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

}
