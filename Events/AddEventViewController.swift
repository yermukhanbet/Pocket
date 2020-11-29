//
//  AddEventViewController.swift
//  Pocket
//
//  Created by Yessen on 11/26/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class AddEventViewController: UIViewController {
    var db: Firestore!
    var scrollView = UIScrollView()
    var eventTitle = ""
    var eventDescription = ""
    var room = ""
    var participants = 0
    var space = 0
    var time = ""
    private func createTextField(with name: String) -> UITextField{
        let text = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))   //padding view from the left side of text field
        text.leftView = paddingView
        text.leftViewMode = .always
        text.backgroundColor = .white
        text.keyboardAppearance = .dark
        text.placeholder = name
        text.font = UIFont.systemFont(ofSize: 12.0)
        text.resignFirstResponder()
        text.layer.cornerRadius = 10
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.masksToBounds = true
        text.clipsToBounds = true
        text.layer.borderWidth = 0.6
        return text
    }
    func createCheckDot() -> UIImageView{
        let image = UIImageView()
        image.backgroundColor = .clear
        return image
    }
    lazy var buildingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select building", for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .white
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.borderWidth = 0.6
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buildingButtonTouched), for: .touchUpInside)
        return button
    }()
    lazy var durationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select duration", for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .white
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.borderWidth = 0.6
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(durationButtoonTouched), for: .touchUpInside)
        return button
    }()
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.setTitle("Post", for: .normal)
        button.addTarget(self, action: #selector(addButtonTouched), for: .touchUpInside)
        return button
    }()
    lazy var textFields = [self.createTextField(with: pocketEventTitle), self.createTextField(with: pocketEventDescription),self.createTextField(with: pocketEventRoom),self.createTextField(with: pocketEventTime)]
    lazy var checkDots = [self.createCheckDot(),self.createCheckDot(),self.createCheckDot(),self.createCheckDot(),self.createCheckDot(),self.createCheckDot()]
    @objc func buildingButtonTouched(){
        let actionSheet = UIAlertController(title: "Choose the building:", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Gwangetto", style: .default, handler: {action in
            self.setBuilding(with: "Gwangetto")
            self.checkDots[4].image = UIImage(named: "correct")
            self.checkDots[4].fadeTransition(0.3)
        }))
        actionSheet.addAction(UIAlertAction(title: "Student Union", style: .default, handler: {action in
            self.setBuilding(with: "Student Union")
            self.checkDots[4].image = UIImage(named: "correct")
            self.checkDots[4].fadeTransition(0.3)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            self.dismiss(animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    @objc func durationButtoonTouched(){
        let actionSheet = UIAlertController(title: "Choose the time:", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "30", style: .default, handler: {action in
            self.setDurationTime(with: "30")
            self.checkDots[5].image = UIImage(named: "correct")
            self.checkDots[5].fadeTransition(0.3)
        }))
        actionSheet.addAction(UIAlertAction(title: "60", style: .default, handler: {action in
            self.setDurationTime(with: "60")
            self.checkDots[5].image = UIImage(named: "correct")
            self.checkDots[5].fadeTransition(0.3)
        }))
        actionSheet.addAction(UIAlertAction(title: "90", style: .default, handler: {action in
            self.setDurationTime(with: "90")
            self.checkDots[5].image = UIImage(named: "correct")
            self.checkDots[5].fadeTransition(0.3)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            self.dismiss(animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    @objc func addButtonTouched(){
        self.post(event: String(self.textFields[0].text!), with: String(self.textFields[1].text!), room: String(self.textFields[2].text!), date: String(self.textFields[3].text!), building: String(buildingButton.titleLabel!.text!), duration: String(durationButton.titleLabel!.text!))
    }
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        setStatusImage(with: "checking", near: textField)
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.placeholder{
        case pocketEventTitle:
            checkTitle(from: textField)
            break
        case pocketEventDescription:
            checkDescription(from: textField)
            break
        case pocketEventRoom:
            checkRomm(from: textField)
            break
        case pocketEventParticipants:
            break
        case pocketEventTime:
            self.checkDateFormat(from: textField)
            break
        case .none:
            break
        case .some(_):
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    private func setUI(){
        self.view.addSubview(scrollView)
        setScrollView()
        self.view.addSubview(addButton)
        setConstraints()
        setupFirestore()
    }
    private func setScrollView(){
        scrollView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        scrollView.backgroundColor = .yellow
        let distanceFromTop = 50
        let height = 40
        let difference = 20
        for item in 0...self.textFields.capacity - 1{
            self.textFields[item].delegate = self
            let totalDistance = distanceFromTop + item*(height + difference)
            let width = self.view.frame.width * 0.8
            let x = (self.view.frame.width * 0.2)/2
            self.textFields[item].frame = CGRect(x: x, y: CGFloat(totalDistance), width: width, height: CGFloat(height))
            self.scrollView.addSubview(self.textFields[item])
            self.checkDots[item].frame = CGRect(x: Int((width+x)) - 20, y: totalDistance +  12, width: 15, height: 15)
            self.scrollView.addSubview(self.checkDots[item])
        }
        let x = (self.view.frame.width*0.2)/2 +  (self.view.frame.width*0.8) - 20
        buildingButton.frame = CGRect(x: (self.view.frame.width*0.2)/2, y: 290, width: self.view.frame.width*0.8, height: 40)
        self.checkDots[4].frame = CGRect(x: x, y: 302, width: 15, height: 15)
        scrollView.addSubview(buildingButton)
        scrollView.addSubview(checkDots[4])
        durationButton.frame = CGRect(x: (self.view.frame.width*0.2)/2, y: 350, width: self.view.frame.width*0.8, height: 40)
        
        self.checkDots[5].frame = CGRect(x: x, y: 362, width: 15, height: 15)
        scrollView.addSubview(durationButton)
        self.scrollView.addSubview(self.checkDots[5])
        scrollView.contentSize  = CGSize(width: self.view.frame.width, height: 370)
    }
    private func setConstraints(){
        addButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.7).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
extension AddEventViewController{
    private func checkTitle(from text: UITextField){
        if text.text!.count > 2{
            setStatusImage(with: "correct", near: text)
        }else{
            setStatusImage(with: "false", near: text)
        }
    }
    private func checkDescription(from text: UITextField){
        if text.text!.count > 2{
            setStatusImage(with: "correct", near: text)
        }else{
            setStatusImage(with: "false", near: text)
        }
    }
    private func checkRomm(from text: UITextField){
        if text.text!.count > 2{
            setStatusImage(with: "correct", near: text)
        }else{
            setStatusImage(with: "false", near: text)
        }
    }
    private func checkDateFormat(from text: UITextField){
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yy-MM-dd "
        let someDate = self.textFields[3].text!
        if dateFormatterGet.date(from: someDate) != nil {
            setStatusImage(with: "correct", near: text)
        } else {
            setStatusImage(with: "false", near: text)
        }
    }
}
extension AddEventViewController{
    private func setStatusImage(with image: String, near to: UITextField){
        switch to.placeholder{
        case pocketEventTitle:
            checkDots[0].image = UIImage(named: image)
            checkDots[0].fadeTransition(0.3)
            break
        case pocketEventDescription:
            checkDots[1].image = UIImage(named: image)
            checkDots[1].fadeTransition(0.3)
            break
        case pocketEventRoom:
            checkDots[2].image = UIImage(named: image)
            checkDots[2].fadeTransition(0.3)
            break
        case pocketEventTime:
            checkDots[3].image = UIImage(named: image)
            checkDots[3].fadeTransition(0.3)
            break
        case .none:
            break
        case .some(_):
            break
        }
    }
    public func setBuilding(with building: String){
        self.buildingButton.setTitle(building, for: .normal)
        self.buildingButton.fadeTransition(0.3)
    }
    public func setDurationTime(with time: String){
        self.durationButton.setTitle(time, for: .normal)
        self.durationButton.fadeTransition(0.3)
    }
}
extension AddEventViewController{
    func setupFirestore(){
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    public func post(event title: String, with description: String, room: String, date: String, building: String, duration: String){
        let number = Int.random(in: 0...999)
        var user = [String: Any]()
        user["email"] = PocketAccount.savedAccount.email
        user["uid"] = "123"
        db.collection("events").document(String(number)).setData(["building":building,"duration":duration, "room":room,"startTime":date,"description":description, "title":title, "user":user])
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
