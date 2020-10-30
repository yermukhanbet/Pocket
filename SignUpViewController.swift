//
//  SignUpViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/31/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    let backgrounImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "backgroundLogo")
        imageView.image = image
        return imageView
    }()
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let pwLabel: UILabel = {
        let label = UILabel()
        label.text = "PW"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let login: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter your Login"
        textField.font = UIFont.systemFont(ofSize: 18.0)
        textField.resignFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let password: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter your Password"
        textField.font = UIFont.systemFont(ofSize: 18.0)
        textField.resignFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(signUpButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let signUpView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    func createSeparationLine() -> UIView{
        let line = UIView()
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }
    lazy var separationLines:[UIView] = [createSeparationLine(),createSeparationLine(), createSeparationLine()]
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        signUpButton.isEnabled = true
    }
    @objc func signUpButtonTouched(){
        AccountManager.sharedInstance.signUp(with: login.text!, for: password.text!){(success) in
            if success{
                let vc = MainTabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .flipHorizontal
                self.present(vc, animated: true)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
    }
    private func addViews(){
        self.view.addSubview(backgrounImage)
        self.view.addSubview(logoImage)
        self.view.addSubview(idLabel)
        self.view.addSubview(pwLabel)
        self.view.addSubview(login)
        self.view.addSubview(password)
        self.view.addSubview(signUpView)
        self.view.addSubview(signUpButton)
        self.view.addSubview(separationLines[0])
        self.view.addSubview(separationLines[1])
        self.view.addSubview(separationLines[2])
    }
    func setupConstraints(){
        backgrounImage.frame = self.view.frame
        setLogoConstraints()
        setSignUpViewConstraint()
        setSignUpButtonConstrain()
        setIdLabelConstraints()
        setPwLabelConstraints()
        setLoginConstraint()
        setPasswordConstraint()
        setSeparationLineConstraint()
    }
    private func setLogoConstraints(){
        logoImage.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 130).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 139).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
    }
    private func setIdLabelConstraints(){
        idLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40).isActive = true
        idLabel.leftAnchor.constraint(equalTo:signUpView.leftAnchor).isActive = true
        idLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    private func setPwLabelConstraints(){
        pwLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 30).isActive = true
        pwLabel.leftAnchor.constraint(equalTo: idLabel.leftAnchor).isActive = true
        pwLabel.heightAnchor.constraint(equalTo: idLabel.heightAnchor).isActive = true
        pwLabel.widthAnchor.constraint(equalTo: idLabel.widthAnchor).isActive = true
    }
    private func setLoginConstraint(){
        login.delegate = self
        login.topAnchor.constraint(equalTo: idLabel.topAnchor).isActive = true
        login.leftAnchor.constraint(equalTo: idLabel.rightAnchor, constant: 5).isActive = true
        login.rightAnchor.constraint(equalTo: signUpView.rightAnchor).isActive = true
        login.heightAnchor.constraint(equalTo: idLabel.heightAnchor).isActive = true
    }
    private func setPasswordConstraint(){
        password.delegate = self
        password.topAnchor.constraint(equalTo: pwLabel.topAnchor).isActive = true
        password.leftAnchor.constraint(equalTo: pwLabel.rightAnchor, constant: 5).isActive = true
        password.widthAnchor.constraint(equalTo: login.widthAnchor).isActive = true
        password.heightAnchor.constraint(equalTo: pwLabel.heightAnchor).isActive = true
    }
    private func setSignUpViewConstraint(){
        signUpView.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 55).isActive = true
        signUpView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signUpView.widthAnchor.constraint(equalToConstant: 254).isActive = true
    }
    private func setSignUpButtonConstrain(){
        signUpButton.topAnchor.constraint(equalTo: signUpView.topAnchor).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: signUpView.widthAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalTo: signUpView.heightAnchor).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: signUpView.centerXAnchor).isActive = true
    }
    private func setSeparationLineConstraint(){
        for line in 0...1{
            separationLines[line].leftAnchor.constraint(equalTo: signUpView.leftAnchor).isActive = true
            separationLines[line].rightAnchor.constraint(equalTo: signUpView.rightAnchor).isActive = true
            separationLines[line].heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        separationLines[0].topAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
        separationLines[1].topAnchor.constraint(equalTo: pwLabel.bottomAnchor).isActive = true
        
        separationLines[2].topAnchor.constraint(equalTo: idLabel.topAnchor).isActive = true
        separationLines[2].bottomAnchor.constraint(equalTo: separationLines[0].topAnchor, constant: -2).isActive = true
        separationLines[2].rightAnchor.constraint(equalTo: login.leftAnchor).isActive = true
        separationLines[2].widthAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
