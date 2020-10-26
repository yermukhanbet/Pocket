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
    let sectionRows: [[String]] = [["Edit Profile", "My Account"],["List of events"], ["Language", "Time fomat","Log out"]]
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
    @objc func loginButtonTouched(){
        let vc = LoginViewController()
        self.present(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
    }
    private func setupNavigationController(){
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6892925942)
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6892925942)
        let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.lightGray, for: .normal)
        loginButton.backgroundColor = .white
        loginButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 0.1
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
        var rightButtons = Array<UIBarButtonItem>()
        let rightButton = UIBarButtonItem(customView: loginButton)
        rightButtons.append(rightButton)
        self.navigationItem.rightBarButtonItems = rightButtons
    }
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6892925942)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6892925942)
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
        headerView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6892925942)
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
        return sectionRows[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        view.backgroundColor = .white
        let headerTitle = UILabel()
        headerTitle.frame = CGRect(x: 10, y: 5, width: 130, height: 70)
        view.addSubview(headerTitle)
        headerTitle.text = sections[section]
        headerTitle.font = .boldSystemFont(ofSize: 23)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6892925942)
        cell.textLabel?.text = sectionRows[indexPath.section][indexPath.row]
        cell.separatorInset = .zero
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
