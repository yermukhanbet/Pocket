//
//  UserDefaults.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/31/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import Foundation

extension UserDefaults{
    enum UserDefaultsKeys: String{
        case isLoggedIn
        case email
        case password
        case uid
    }
    func setIsLoggedIn(value: Bool){
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    func isLoggedIn() -> Bool{
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    func saveAccount(email: String, password: String, uid: String = "asd"){
        set(email, forKey: UserDefaultsKeys.email.rawValue)
        set(password, forKey: UserDefaultsKeys.password.rawValue)
        set(uid, forKey: UserDefaultsKeys.uid.rawValue)
    }
    func deleteAccount(){
        set(nil, forKey: UserDefaultsKeys.email.rawValue)
        set(nil, forKey: UserDefaultsKeys.password.rawValue)
        set(nil, forKey: UserDefaultsKeys.uid.rawValue)
    }
    func getAccountData() -> [String: Any]{
        let email = UserDefaults.standard.object(forKey: UserDefaultsKeys.email.rawValue) as! String
        let password =  UserDefaults.standard.object(forKey: UserDefaultsKeys.password.rawValue) as! String
        let uid = UserDefaults.standard.object(forKey: UserDefaultsKeys.uid.rawValue) as! String
        let data: [String: Any] = ["email":email, "password":password, "uid": uid]
        return data
    }
    func signOut(){
        setIsLoggedIn(value: false)
        deleteAccount()
    }
}
