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
    static var savedAccount = PocketAccount()
    init(email: String, password: String){
        self.email = email
        self.password = password
        self.nickName = "Pocket user"
    }
    override init(){
        self.email = ""
        self.password = ""
        self.nickName = "Pocket user"
    }
     required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
