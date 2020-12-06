//
//  NrwEventViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 11/5/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class NewEventViewController: UIViewController {
    var db: Firestore!
    var time: String = ""
    struct Event{
        let title: String
        let description: String
    }
    let titleText: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter the title of your event"
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.masksToBounds = true
        textField.clipsToBounds = true
        textField.layer.borderWidth = 0.6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let descriptionText: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter the description of your event"
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: UIControl.Event.editingChanged)
        textField.layer.masksToBounds = true
        textField.clipsToBounds = true
        textField.layer.borderWidth = 0.6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var building: UIButton = {
        let button = UIButton()
        button.setTitle("Set building", for: .normal)
        return button
    }()
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.masksToBounds = true
        button.setTitle("Post", for: .normal)
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    @objc func buildingPressed(){
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Click", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func addPressed(){
        post(event: titleText.text!, with: descriptionText.text!)
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        addButton.isEnabled = true
        addButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addButton.fadeTransition(0.8)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        setupFirestore()
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
    func addSubviews(){
        self.view.addSubview(titleText)
        self.view.addSubview(descriptionText)
        self.view.addSubview(addButton)
    }
    func setConstraints(){
        titleText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 100).isActive = true
        titleText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor,constant: 30).isActive = true
        descriptionText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupFirestore(){
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    public func post(event title: String, with description: String){
        let number = Int.random(in: 0...999)
        var user = [String: Any]()
        user["email"] = PocketAccount.savedAccount.email
        user["uid"] = "123"
        db.collection("events").document(String(number)).setData(["description":description, "title":title, "user":user])
        getData()
        showMessage()
    }
    public func getData(){
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.data())")
                }
            }
        }
    }
    func showMessage(){
        let alert = UIAlertController(title: "Success", message:  "Your event successfully added!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
}
public struct City: Codable {

    let name: String
    let state: String?
    let country: String?
    let isCapital: Bool?
    let population: Int64?

    enum CodingKeys: String, CodingKey {
        case name
        case state
        case country
        case isCapital = "capital"
        case population
    }

}
