import UIKit

class SettingsViewController: UIViewController {
    lazy var tableView = UITableView()
    let sectionRows: [[String]] = [[PocketPolicyLabel], [PocketLogoutLabel]]
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "default_profile")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 40
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.borderWidth = 0.1
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var profileNickName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.text = PocketAccount.savedAccount.nickName
        return label
    }()
    lazy var profileEmail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = PocketAccount.savedAccount.email
        return label
    }()
    @objc func buttonActionHandler(_ sender: UIButton){
        switch sender.titleLabel?.text{
        case PocketPolicyLabel:
        let actionSheet = UIAlertController(title: pocketPrivacyTitle, message: pocketPrivacyDescription, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Close", style: .cancel, handler: {action in
            self.dismiss(animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)
            break
        case PocketLogoutLabel:
            AccountManager.sharedInstance.signOut()
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            break
        case .none:
            break
        case .some(_):
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationBar(animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar(animated: true)
    }
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 220))
        headerView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        //Profile image in header view
        headerView.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 52).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        //Profile name in header view
        headerView.addSubview(profileNickName)
        profileNickName.topAnchor.constraint(equalTo: profileImage.bottomAnchor,constant: 10).isActive = true
        profileNickName.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        profileNickName.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        profileNickName.heightAnchor.constraint(equalToConstant: 22).isActive = true
        headerView.addSubview(profileEmail)
        profileEmail.topAnchor.constraint(equalTo: profileNickName.bottomAnchor,constant: 10).isActive = true
        profileEmail.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        profileEmail.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        profileEmail.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionRows[section].count
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 15)
        view.backgroundColor = #colorLiteral(red: 0.9065746577, green: 0.9065746577, blue: 0.9065746577, alpha: 1)
        return view
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: self.view.frame.width, height: 72))
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonActionHandler), for: .touchUpInside)
        button.setTitle(sectionRows[indexPath.section][indexPath.row], for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        cell.backgroundColor = .white
        cell.separatorInset = .zero
        cell.contentView.addSubview(button)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionRows.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension UIViewController {
    func hideNavigationBar(animated: Bool){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    func showNavigationBar(animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
