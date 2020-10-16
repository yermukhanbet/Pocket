//
//  LoginViewController.swift
//  Capstone
//
//  Created by Yessen Yermukhanbet on 10/12/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let loginText: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter your Login"
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.masksToBounds = true
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let passwordText: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter your Password"
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: UIControl.Event.editingChanged)
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.masksToBounds = true
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .black
        button.layer.masksToBounds = true
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.isEnabled = true
        return button
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .black
        button.layer.masksToBounds = true
        button.setTitle("Sign up", for: .normal)
        button.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        loginButton.isEnabled = true
    }
    @objc func loginPressed(){
        let vc = MainTabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @objc func signUpPressed(){
        let vc = MainTabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    private func addSubViews(){
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        view.addSubview(loginText)
        view.addSubview(passwordText)
    }
    
    private func setupConstraints(){
        setupLoginButtonConstraints()
        setupSignUpConstraints()
        setupLoginTextConstraints()
        setupPasswordTextConstraints()
    }
    private func setupLoginTextConstraints(){
        loginText.delegate = self
        loginText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        loginText.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        loginText.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        loginText.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func setupPasswordTextConstraints(){
        passwordText.delegate = self
        passwordText.topAnchor.constraint(equalTo: loginText.bottomAnchor, constant: 20).isActive = true
        passwordText.leftAnchor.constraint(equalTo: loginText.leftAnchor).isActive = true
        passwordText.rightAnchor.constraint(equalTo: loginText.rightAnchor).isActive = true
        passwordText.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func setupLoginButtonConstraints(){
        loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 600).isActive = true
        loginButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func setupSignUpConstraints(){
        signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        signUpButton.leftAnchor.constraint(equalTo: loginButton.leftAnchor).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: loginButton.rightAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
    }
}
extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
