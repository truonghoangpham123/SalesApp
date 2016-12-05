//
//  SignInVC.swift
//  SalesApp
//
//  Created by Mac-ninjaKID on 11/28/16.
//  Copyright © 2016 KobePham. All rights reserved.
//  test

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.stringForKey(KEY_UID) {
            print("JESS: ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

//    btn facebook Login
    @IBAction func facebookBtnTapped(_ sender: Any) {

        let facebookLogin = FBSDKLoginManager()
        
            facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
                    if error != nil {
                        print("JESS: Unable to authenticate with Facebook - \(error)")
                    } else if result?.isCancelled == true {
                        print("JESS: User cancelled Facebook authentication")
                    } else {
                        print("JESS: Successfully authenticated with Facebook")
                        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                        self.firebaseAuth(credential)
                    }
                }
    }

    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(
            with: credential,
            completion: { (user, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JESS: Successfully authenticated with Firebase")
                if let user = user{
                    self.completeSignIn(id: user.uid)
                }

            }
        })
    }

//    btn Sign In Email & Pwd
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(
                withEmail: email,
                password: pwd,
                completion: { (user, error) in
                // ...
                    if error == nil{
                        print("JESS: Email user authenticated with Firebase - \(error)")
                        if let user = user{
                            self.completeSignIn(id: user.uid)
                        }
                    }else{
                        FIRAuth.auth()?.createUser(
                            withEmail: email,
                            password: pwd,
                            completion: { (user, error) in
                                if error != nil{
                                    print("JESS: Unable to authenticate with Firebase with Email - \(error)")
                                }
                                else{
                                    print("JESS: Successfully authenticated with Firebase with Email")
                                    if let user = user{
                                        self.completeSignIn(id: user.uid)
                                    }
                                }
                        })
                    }
                })
        }

    }

    func completeSignIn(id: String) {
        let keyChainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        print("JESS: Data Save Keychain \(keyChainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

