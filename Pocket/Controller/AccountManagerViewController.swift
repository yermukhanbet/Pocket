//
//  AccountManagerViewController.swift
//  Pocket
//
//  Created by Yessen Yermukhanbet on 10/31/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
class AccountManager: NSObject {
    static let sharedInstance = AccountManager()
    public func signIn(with email: String, for password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                UserDefaults.standard.setIsLoggedIn(value: false)
                completion(false)
            } else {
                print(result)
                let user = Auth.auth().currentUser
                if let user = user{
                    let uid = user.uid
                    let email = user.email
                    self.save(user: email!, with: password, uid: uid)
                    let tempAccount = PocketAccount(email: email!, password: password, uid: uid)
                    PocketAccount.savedAccount = tempAccount
                    completion(true)
                }
                completion(false)
            }
        }
    }
    public func signUp(with email: String, for password: String,and id: String, completion: @escaping (_ success: Bool, _ uid: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil{
                let user = Auth.auth().currentUser
                if let user = user{
                    let uid = user.uid
                    self.save(user: email, with: password, uid: uid)
                    completion(true, uid)
                }
            }else{
                completion(false, "nil")
            }
        }
    }
    public func signOut(){
        UserDefaults.standard.signOut()
    }
    public func save(user:String, with password: String, uid: String){
        UserDefaults.standard.saveAccount(email: user, password: password, uid: uid)
        UserDefaults.standard.setIsLoggedIn(value: true)
        let tempAcc = PocketAccount(email: user, password: password)
        PocketAccount.savedAccount = tempAcc
    }
}
