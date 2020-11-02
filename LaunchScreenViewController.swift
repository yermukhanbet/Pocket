//
//  LaunchScreenViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/30/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import Reachability
import Firebase

class LaunchScreenViewController: UIViewController {
    var progressAmount:Float = 0.0
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = .systemRed
        progress.tintColor = .systemGray
        progress.setProgress(0, animated: true)
        progress.layer.borderWidth =  1.0
        progress.layer.borderColor = UIColor.lightGray.cgColor
        progress.layer.cornerRadius = 5
        progress.layer.masksToBounds = true
        return progress
    }()
    let explanationText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Loading"
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    let refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0.2
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        return button
    }()
    let refreshButotnShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowOffset =  CGSize.zero
        view.layer.shadowRadius = 9
        view.layer.shadowOpacity = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let messageView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    @objc func refreshButtonPressed(){
        //checkPoints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
    }
    override func viewDidLayoutSubviews() {
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.checkPoints()
        }
    }
    private func checkPoints(){
        startUI()
        if !checkForInternet(){return}
        checkUserLogin()
    }
    private func startUI(){
        self.progressAmount = 0.0
        self.progressView.setProgress(self.progressAmount, animated: true)
        self.refreshButton.setImage(nil, for: .normal)
        self.refreshButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.refreshButotnShadow.layer.shadowOpacity = 0
        self.refreshButton.fadeTransition(0.3)
        self.refreshButotnShadow.fadeTransition(0.3)
        self.messageView.backgroundColor = .clear
        self.messageView.text = ""
        self.messageView.fadeTransition(0.3)
    }
    private func hideUI(){
        self.messageView.backgroundColor = .white
        self.messageView.text = PocketNoInternetConnection
        self.messageView.textColor = .black
        self.messageView.fadeTransition(0.5)
        self.refreshButton.setImage(UIImage(named: "refreshButton"), for: .normal)
        self.refreshButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.refreshButotnShadow.layer.shadowOpacity = 0.5
        self.refreshButton.fadeTransition(0.5)
        self.refreshButotnShadow.fadeTransition(0.5)
    }
    fileprivate func updateProgressBar() {
        self.progressAmount = self.progressAmount + 0.3
        self.progressView.setProgress(self.progressAmount, animated: true)
    }
    private func addSubviews(){
        self.view.addSubview(logoImage)
        self.view.addSubview(progressView)
        self.view.addSubview(explanationText)
        self.view.addSubview(refreshButotnShadow)
        self.view.addSubview(refreshButton)
        self.view.addSubview(messageView)
    }
    private func setConstraints(){
        setLogoConstraints()
        setProgressViewConstraints()
        setupExplanationTextConstraints()
        setupRefreshButton()
        setupMessageViewConstraints()
    }
    private func setLogoConstraints(){
        logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    private func setProgressViewConstraints(){
        progressView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40).isActive = true
        progressView.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    private func setupExplanationTextConstraints(){
        explanationText.topAnchor.constraint(equalTo: progressView.bottomAnchor).isActive = true
        explanationText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        explanationText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        explanationText.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    private func setupRefreshButton(){
        refreshButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        refreshButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        refreshButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        refreshButotnShadow.topAnchor.constraint(equalTo: refreshButton.topAnchor).isActive = true
        refreshButton.bottomAnchor.constraint(equalTo: refreshButton.bottomAnchor).isActive = true
        refreshButton.leftAnchor.constraint(equalTo: refreshButton.leftAnchor).isActive = true
        refreshButton.rightAnchor.constraint(equalTo: refreshButton.rightAnchor).isActive = true
    }
    private func setupMessageViewConstraints(){
        messageView.topAnchor.constraint(equalTo: progressView.topAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: explanationText.bottomAnchor).isActive = true
        messageView.leftAnchor.constraint(equalTo: progressView.leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: progressView.rightAnchor).isActive = true
    }
    private func checkForInternet() -> Bool{
        let reachability = try! Reachability()
        if reachability.isReachable{
            updateProgressBar()
            return true
        }else{
            hideUI()
            return false
        }
    }
    private func checkUserLogin() {
        updateProgressBar()
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            if self.userIsLoggedIn(){
                let account:[String: Any] = UserDefaults.standard.getAccountData()
                let email = account["email"] as! String
                let password = account["password"] as! String
                AccountManager.sharedInstance.signIn(with: email, for: password){(success) in
                    if success{
                        let vc = MainTabBarViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }else{
                        self.showMessage()
                    }
                }
            }else{
                let loginViewController = LoginViewController()
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
    private func userIsLoggedIn() -> Bool{
        return UserDefaults.standard.isLoggedIn()
    }
    func showMessage(){
        let alert = UIAlertController(title: PocketUserLoginError, message:  PocketUserPasswordChangedMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sign in", style: .default, handler: {action in
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
}
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
