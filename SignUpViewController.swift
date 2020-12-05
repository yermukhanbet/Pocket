//
//  SignUpViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/31/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class SignUpViewController: UIViewController {
    var db: Firestore!
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
    let studentLabel: UILabel = {
        let label = UILabel()
        label.text = "SN"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NM"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let departmentLabel: UILabel = {
        let label = UILabel()
        label.text = "DP"
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
        textField.placeholder = "Enter your Email"
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
    let studentId: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter your Student id"
        textField.font = UIFont.systemFont(ofSize: 18.0)
        textField.resignFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let name: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter your name"
        textField.font = UIFont.systemFont(ofSize: 18.0)
        textField.resignFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let department: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter your department"
        textField.font = UIFont.systemFont(ofSize: 18.0)
        textField.resignFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.backgroundColor = #colorLiteral(red: 0.6008817554, green: 0.5973126888, blue: 0.6036270857, alpha: 1)
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
    let wrongDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 13)
        label.text = PocketInvalidDataLabel
        label.textAlignment = .center
        label.textColor = .clear
        return label
    }()
    lazy var separationLines:[UIView] = [createSeparationLine(),createSeparationLine(), createSeparationLine(), createSeparationLine(), createSeparationLine()]
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.placeholder{
        case "Enter your Password":
            if textField.text!.count<6{
                showWrongDataLabel()
                signUpView.backgroundColor = #colorLiteral(red: 0.6008817554, green: 0.5973126888, blue: 0.6036270857, alpha: 1)
                signUpView.fadeTransition(0.8)
                break
            }else{
                signUpButton.isEnabled = true
                signUpView.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                signUpView.fadeTransition(0.8)
                break
            }
        case .none:
            break
        case .some(_):
            break
        }
    }
    @objc func signUpButtonTouched(){
        AccountManager.sharedInstance.signUp(with: login.text!, for: password.text!, and: studentId.text!){(success, uid) in
            if success{
                let settings = FirestoreSettings()
                Firestore.firestore().settings = settings
                self.db = Firestore.firestore()
                var payload = [String: Any]()
                payload["name"] = self.name.text!
                payload["studentId"] = self.studentId.text!
                payload["department"] = self.department.text!
                self.db.collection("users").document(uid).setData(["payload":payload, "uid":uid])
                let vc = MainTabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .flipHorizontal
                self.present(vc, animated: true)
            }else{
                self.showWrongDataLabel()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    private func addViews(){
        self.view.addSubview(backgrounImage)
        self.view.addSubview(logoImage)
        self.view.addSubview(idLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(studentLabel)
        self.view.addSubview(departmentLabel)
        self.view.addSubview(pwLabel)
        self.view.addSubview(login)
        self.view.addSubview(name)
        self.view.addSubview(studentId)
        self.view.addSubview(department)
        self.view.addSubview(password)
        self.view.addSubview(signUpView)
        self.view.addSubview(signUpButton)
        self.view.addSubview(separationLines[0])
        self.view.addSubview(separationLines[1])
        self.view.addSubview(separationLines[2])
        self.view.addSubview(separationLines[3])
        self.view.addSubview(separationLines[4])
        view.addSubview(wrongDataLabel)
    }
    func setupConstraints(){
        backgrounImage.frame = self.view.frame
        setLogoConstraints()
        setSignUpViewConstraint()
        setSignUpButtonConstrain()
        setIdLabelConstraints()
        setNameLabelConstraints()
        setNumberLabelConstraints()
        departmentLabelConstraints()
        setPwLabelConstraints()
        setLoginConstraint()
        setNameConstraints()
        setNumberConstraints()
        setDepartmentConstraint()
        setPasswordConstraint()
        setSeparationLineConstraint()
        setupWrongDataLabel()
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
    private func setNameLabelConstraints(){
        nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 30).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: idLabel.leftAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: idLabel.heightAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: idLabel.widthAnchor).isActive = true
    }
    private func setNumberLabelConstraints(){
        studentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        studentLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        studentLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        studentLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
    }
    private func departmentLabelConstraints(){
        departmentLabel.topAnchor.constraint(equalTo: studentLabel.bottomAnchor, constant: 30).isActive = true
        departmentLabel.leftAnchor.constraint(equalTo: studentLabel.leftAnchor).isActive = true
        departmentLabel.heightAnchor.constraint(equalTo: studentLabel.heightAnchor).isActive = true
        departmentLabel.widthAnchor.constraint(equalTo: studentLabel.widthAnchor).isActive = true
    }
    private func setPwLabelConstraints(){
        pwLabel.topAnchor.constraint(equalTo: departmentLabel.bottomAnchor, constant: 30).isActive = true
        pwLabel.leftAnchor.constraint(equalTo: departmentLabel.leftAnchor).isActive = true
        pwLabel.heightAnchor.constraint(equalTo: departmentLabel.heightAnchor).isActive = true
        pwLabel.widthAnchor.constraint(equalTo: departmentLabel.widthAnchor).isActive = true
    }
    private func setLoginConstraint(){
        login.delegate = self
        login.topAnchor.constraint(equalTo: idLabel.topAnchor).isActive = true
        login.leftAnchor.constraint(equalTo: idLabel.rightAnchor, constant: 5).isActive = true
        login.rightAnchor.constraint(equalTo: signUpView.rightAnchor).isActive = true
        login.heightAnchor.constraint(equalTo: idLabel.heightAnchor).isActive = true
    }
    //name
    private func setNameConstraints(){
        name.delegate = self
        name.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        name.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 5).isActive = true
        name.widthAnchor.constraint(equalTo: login.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
    }
    private func setNumberConstraints(){
        studentId.delegate = self
        studentId.topAnchor.constraint(equalTo: studentLabel.topAnchor).isActive = true
        studentId.leftAnchor.constraint(equalTo: studentLabel.rightAnchor, constant: 5).isActive = true
        studentId.widthAnchor.constraint(equalTo: login.widthAnchor).isActive = true
        studentId.heightAnchor.constraint(equalTo: studentLabel.heightAnchor).isActive = true
    }
    private func setDepartmentConstraint(){
        department.delegate = self
        department.topAnchor.constraint(equalTo: departmentLabel.topAnchor).isActive = true
        department.leftAnchor.constraint(equalTo: departmentLabel.rightAnchor, constant: 5).isActive = true
        department.widthAnchor.constraint(equalTo: studentId.widthAnchor).isActive = true
        department.heightAnchor.constraint(equalTo: departmentLabel.heightAnchor).isActive = true
    }
    private func setPasswordConstraint(){
        password.delegate = self
        password.topAnchor.constraint(equalTo: pwLabel.topAnchor).isActive = true
        password.leftAnchor.constraint(equalTo: pwLabel.rightAnchor, constant: 5).isActive = true
        password.widthAnchor.constraint(equalTo: studentId.widthAnchor).isActive = true
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
        for line in 0...4{
            separationLines[line].leftAnchor.constraint(equalTo: signUpView.leftAnchor).isActive = true
            separationLines[line].rightAnchor.constraint(equalTo: signUpView.rightAnchor).isActive = true
            separationLines[line].heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        separationLines[0].topAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
        separationLines[1].topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        separationLines[2].topAnchor.constraint(equalTo: studentLabel.bottomAnchor).isActive = true
        separationLines[3].topAnchor.constraint(equalTo: departmentLabel.bottomAnchor).isActive = true
        separationLines[4].topAnchor.constraint(equalTo: pwLabel.bottomAnchor).isActive = true
    }
    private func setupWrongDataLabel(){
        wrongDataLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        wrongDataLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        wrongDataLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        wrongDataLabel.widthAnchor.constraint(equalToConstant:
            240).isActive = true
    }
    private func showWrongDataLabel(){
        self.wrongDataLabel.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.168627451, blue: 0.3647058824, alpha: 1)
        self.wrongDataLabel.textColor = .white
        self.wrongDataLabel.fadeTransition(0.3)
        let deadline = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.wrongDataLabel.backgroundColor = .clear
            self.wrongDataLabel.textColor = .clear
            self.wrongDataLabel.fadeTransition(0.6)
        }
    }
}
