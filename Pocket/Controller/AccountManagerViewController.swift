//
//  AccountManagerViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/31/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import FirebaseAuth
class AccountManager: NSObject {
    static let sharedInstance = AccountManager()
    public func signIn(with email: String, for password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                UserDefaults.standard.setIsLoggedIn(value: false)
                completion(false)
            } else {
                self.save(user: email, with: password)
                let tempAccount = PocketAccount(email: email, password: password)
                PocketAccount.savedAccount = tempAccount
                completion(true)
            }
        }
    }
    public func signUp(with email: String, for password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil{
                self.save(user: email, with: password)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    public func signOut(){
        UserDefaults.standard.signOut()
    }
    public func save(user:String, with password: String){
        UserDefaults.standard.saveAccount(email: user, password: password)
        UserDefaults.standard.setIsLoggedIn(value: true)
        let tempAcc = PocketAccount(email: user, password: password)
        PocketAccount.savedAccount = tempAcc
    }
}
