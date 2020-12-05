//
//  PocketAccount.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/31/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit

class PocketAccount: NSObject {
    
    var email: String
    var password: String
    var nickName: String
    var department: String
    var studentID: String
    var uid: String
    static var savedAccount = PocketAccount()
    init(email: String, password: String, name: String = "user", department: String = "cs", id: String = "111", uid: String = "asd") {
        self.email = email
        self.password = password
        self.nickName = name
        self.department = department
        self.studentID = id
        self.uid = uid
    }
    override init(){
        self.email = ""
        self.password = ""
        self.nickName = "Pocket user"
        self.department = ""
        self.studentID = ""
        self.uid = ""
    }
     required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
