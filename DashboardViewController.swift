//
//  DashboardViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 11/5/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    lazy var scrollView = UIScrollView()
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
    lazy var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gathering")
        imageView.backgroundColor = .white
        return imageView
    }()
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Pocket Dashboard page!"
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    func createButton() -> UIButton{
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(buttonHandler(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    func createView() -> UIView{
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.borderWidth = 0.15
        view.layer.masksToBounds = true
        return view
    }
    func createTitle() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }
    func createDescription() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        return label
    }
    func createQuestionButton() -> UIButton{
        let button = UIButton()
        button.setImage(UIImage(named: "questionButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(questionTouched(_:)), for: .touchUpInside)
        return button
    }
    func createImages() -> UIImageView{
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }
    lazy var questionTitles: [String] = [pocketEventTitle, pocketMapTitle, pocketAddEventTitle]
    lazy var questionDescription: [String] = [pocketEventsDescription,pocketMapDescription,pocketAddEventDescription]
    lazy var views:[UIView] = [createView(),createView(),createView(),createView(), createView()]
    lazy var titles:[UILabel] = [createTitle(),createTitle(),createTitle(),createTitle(), createTitle()]
    lazy var descriptions: [UILabel] = [createDescription(),createDescription(),createDescription(),createDescription(), createDescription()]
    lazy var questionButtons: [UIButton] = [createQuestionButton(),createQuestionButton(),createQuestionButton(),createQuestionButton(), createQuestionButton()]
    lazy var titleString:[String] = [PocketDashTitleFirst,PocketDashTitleSecond,PocketDashTitleThird,PocketDashTitleFourth,PocketDashTitleFifth]
    lazy var titleDescription:[String] = [PocketDashDescriptionFirst,PocketDashDescriptionSecond,PocketDashDescriptionThird,PocketDashDescriptionFourth,PocketDashDescriptionFifth]
    lazy var logoImages: [UIImageView] = [createImages(),createImages(),createImages(),createImages(),createImages()]
    lazy var logoImagesName:[String] = ["image0","image1","image2","image3","image4","image5","image6"]
    lazy var buttons: [UIButton] = [createButton(),createButton(),createButton(),createButton(), createButton()]
    @objc func buttonHandler(_ sender: UIButton){
        let number = Int((sender.titleLabel?.text)!)
        if (number! > 2){
            self.showWrongDataLabel()
        }else{
            transition(to: number!)
        }
    }
    @objc func questionTouched(_ sender: UIButton){
        let number = Int((sender.titleLabel?.text)!)
        if (number! > 2){
            self.showWrongDataLabel()
        }else {
            let actionSheet = UIAlertController(title: self.questionTitles[number!], message: self.questionDescription[number!], preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Close", style: .cancel, handler: {action in
                self.dismiss(animated: true, completion: nil)
            }))
            present(actionSheet, animated: true, completion: nil)
        }
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
    private func transition(to number: Int){
        if number == 0{
            let vc = MainEventsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if number == 1{
            let vc = MapViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = AddEventViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupScrollView()
        self.view.addSubview(wrongDataLabel)
        setupWrongDataLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationBar(animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar(animated: true)
    }
    func setupScrollView(){
        scrollView.frame = self.view.frame
        scrollView.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        scrollView.bounces = true
        view.addSubview(scrollView)
        scrollView.bounces = true
        addSubView()
    }
    func addSubView(){
        let topView = UIView(frame: CGRect(x: 0, y: -100, width: self.view.frame.width, height: 350))
        topView.backgroundColor = .white
        scrollView.addSubview(topView)
        headerImage.frame = CGRect(x: 0, y: -5, width: self.view.frame.width, height: 210)
        self.scrollView.addSubview(headerImage)
        headerTitle.frame = CGRect(x: 5, y: 190, width: self.view.frame.width - 5, height: 60)
        self.scrollView.addSubview(headerTitle)
        var fullDistance = 300
        for item in 0...buttons.count - 1{
            let distanceFromTop = 260
            let ydifference = 10
            let height = 100
            let width = 160
            let xdifference = (Int(self.view.frame.width) - width*2)/3
            let y = distanceFromTop + ydifference*((item/2) + 1) + (item/2)*height
            let x = ((item%2) + 1)*xdifference + (item%2)*width
            views[item].frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
            self.scrollView.addSubview(views[item])
            add(title: titles[item], logo: logoImages[item], description: descriptions[item], question: questionButtons[item], button: buttons[item], to: views[item], at: item)
            questionButtons[item].setTitle(String(item), for: .normal)
            questionButtons[item].setTitleColor(.clear, for: .normal)
            buttons[item].setTitle(String(item), for: .normal)
            buttons[item].setTitleColor(.clear, for: .normal)
            fullDistance = y + 150
        }
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(fullDistance))
    }
    private func add(title: UILabel, logo: UIImageView, description: UILabel, question: UIButton, button: UIButton, to box: UIView, at number: Int){
        logo.image = UIImage(named: logoImagesName[number])
        title.text = titleString[number]
        description.text = titleDescription[number]
        box.addSubview(logo)
        logo.topAnchor.constraint(equalTo: box.topAnchor).isActive = true
        logo.leftAnchor.constraint(equalTo: box.leftAnchor, constant: 5).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        box.addSubview(title)
        title.topAnchor.constraint(equalTo: logo.bottomAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: box.leftAnchor, constant: 5).isActive = true
        title.heightAnchor.constraint(equalToConstant: 10).isActive = true
        title.widthAnchor.constraint(equalToConstant: 150).isActive = true
        box.addSubview(description)
        description.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        description.leftAnchor.constraint(equalTo: title.leftAnchor).isActive = true
        description.heightAnchor.constraint(equalToConstant: 40).isActive = true
        description.widthAnchor.constraint(equalToConstant: 150).isActive = true
        box.addSubview(button)
        button.topAnchor.constraint(equalTo: box.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: box.bottomAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: box.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: box.rightAnchor).isActive = true
        box.addSubview(question)
        question.topAnchor.constraint(equalTo: box.topAnchor, constant: 5).isActive = true
        question.rightAnchor.constraint(equalTo: box.rightAnchor, constant: -10).isActive = true
        question.widthAnchor.constraint(equalToConstant: 15).isActive = true
        question.heightAnchor.constraint(equalToConstant: 15).isActive = true
        if number < 3{
            box.backgroundColor = .white
        }else{
            box.backgroundColor = #colorLiteral(red: 0.9308573921, green: 0.9308573921, blue: 0.9308573921, alpha: 1)
        }
    }
    private func setupWrongDataLabel(){
        wrongDataLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        wrongDataLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        wrongDataLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        wrongDataLabel.widthAnchor.constraint(equalToConstant:
            240).isActive = true
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
