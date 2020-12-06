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
        view.layer.masksToBounds = true
        return view
    }()
    let eventName: UILabel = {
        let label = UILabel()
        label.text = "Event name"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    let eventDescriptioon: UILabel = {
        let label = UILabel()
        label.text = "Event name"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    let eventBuilding: UILabel =  {
        let label = UILabel()
        label.text = "Event name"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    let eventDuration: UILabel = {
        let label = UILabel()
        label.text = "Event name"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    let eventTime: UILabel = {
        let label = UILabel()
        label.text = "Event name"
        label.font = .boldSystemFont(ofSize: 14)
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
        backView.addSubview(eventName)
        backView.addSubview(eventDescriptioon)
        backView.addSubview(eventBuilding)
        backView.addSubview(eventTime)
        backView.addSubview(eventDuration)
    }
    private func setConstraints(){
        setBackViewConstraints()
        eventName.frame = CGRect(x: 10, y: 10, width: self.contentView.frame.width * 0.8, height: 20)
        eventDescriptioon.frame = CGRect(x: 10, y: 30, width: self.contentView.frame.width * 0.8, height: 20)
        eventBuilding.frame = CGRect(x: 10, y: 50, width: self.contentView.frame.width * 0.8, height: 20)
        eventTime.frame = CGRect(x: 10, y: 70, width: self.contentView.frame.width * 0.8, height: 20)
        eventDuration.frame = CGRect(x: 10, y: 90, width: self.contentView.frame.width * 0.8, height: 20)
    }
    private func setBackViewConstraints(){
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        backView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    public func setDetailss(name: String, description: String, building: String, time: String, duration: String){
        self.eventName.text = "Name: \(name)"
        self.eventDescriptioon.text = "Description:\(description)"
        self.eventBuilding.text = "Building: \(building)"
        self.eventTime.text = "Date: \(time)"
        self.eventDuration.text = "Duration: \(duration)"
        self.eventName.fadeTransition(0.3)
        self.eventDescriptioon.fadeTransition(0.3)
        self.eventBuilding.fadeTransition(0.3)
        self.eventTime.fadeTransition(0.3)
        self.eventDuration.fadeTransition(0.3)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
