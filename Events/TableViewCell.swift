//
//  TableViewCell.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/26/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 0.1
        view.layer.masksToBounds = true
        return view
    }()
    let eventPic: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "events_default")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 0.1
        imageView.layer.cornerRadius = 40
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let eventName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Event name"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }
    private func addViews(){
        self.contentView.addSubview(backView)
        backView.addSubview(eventPic)
        //backView.addSubview(eventName)
    }
    private func setConstraints(){
        setBackViewConstraints()
        setEventPicConstraints()
    }
    private func setBackViewConstraints(){
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        backView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    private func setEventPicConstraints(){
        eventPic.topAnchor.constraint(equalTo: backView.topAnchor, constant: 100).isActive = true
        eventPic.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30).isActive = true
        eventPic.heightAnchor.constraint(equalToConstant: 130).isActive = true
        eventPic.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    private func setEventNameConstraints(){
        eventName.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
