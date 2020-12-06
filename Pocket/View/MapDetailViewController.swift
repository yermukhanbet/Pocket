//
//  MapDetailViewController.swift
//  Pocket
//
//  Created by HANTEOGLOBAL on 11/30/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class MapDetailViewController: UIViewController {
    var type: String = ""
    var db: Firestore!
    var scrollView = UIScrollView()
    lazy var mainInfo: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    func createInfoView() -> UIView{
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 0.3
        return view
    }
    func createInfoLabel() -> UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }
    func createInfoTitle() -> UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }
    var infoViews: [UIView] = []
    var infoLabels: [UILabel] = []
    var infoTitles: [UILabel] = []
    init(type: String){
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)
        setFireStore()
        setScroll()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    private func setFireStore(){
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    private func setScroll(){
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
        mainInfo.frame = CGRect(x: 10, y: 20, width: self.view.frame.width - 20, height: 80)
        scrollView.addSubview(mainInfo)
    }
    private func getData(){
        let docRef = db.collection("buildings").document(self.type)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                _ = document.data().map(String.init(describing:)) ?? "nil"
                guard let data = document.data() else{
                    return
                }
                self.setData(data: data)
            } else {
                print("Document does not exist")
            }
        }
    }
    private func setData(data: [String: Any]){
        if let text = data["description"] as? String{
            let description = text.htmlDecoded
            self.mainInfo.text = description
        }
        self.mainInfo.fadeTransition(0.8)
        guard let facilities = data["facilities"] as? [[String:Any]] else{
            return
        }
        if facilities.count != 0{
            addExtraViews(data: facilities)
        }
    }
    private func addExtraViews(data: [[String: Any]]){
        for _ in 0...data.count - 1{
            self.infoViews.append(createInfoView())
            self.infoLabels.append(createInfoLabel())
            self.infoTitles.append(createInfoTitle())
        }
        for item in 0...self.infoViews.count - 1{
            let y = 100
            let difference = 10
            let height = 150
            let width = self.view.frame.width - 20
            let total = y + item*(difference + height)
            self.infoViews[item].frame = CGRect(x: 10, y: total, width: Int(width), height: height)
            scrollView.addSubview(self.infoViews[item])
            self.infoTitles[item].frame = CGRect(x: 5, y: 10, width: self.infoViews[item].frame.width - 10, height: 20)
            self.infoLabels[item].frame = CGRect(x: 5, y: 40, width: self.infoViews[item].frame.width - 10, height: 100)
            if let info = data[item]["description"] as? String{
                let infoString = info.htmlDecoded
                self.infoLabels[item].text = infoString
                self.infoLabels[item].fadeTransition(0.3)
            }
            if let title = data[item]["name"] as? String{
                self.infoTitles[item].text = title
                self.infoTitles[item].fadeTransition(0.3)
            }
            self.infoViews[item].addSubview(self.infoTitles[item])
            self.infoViews[item].addSubview(self.infoLabels[item])
        }
        let total = 100 + self.infoViews.count * (160)
        let width = self.view.frame.width
        scrollView.contentSize = CGSize(width: width, height: CGFloat(total))
    }
}

extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string

        return decoded ?? self
    }
}
