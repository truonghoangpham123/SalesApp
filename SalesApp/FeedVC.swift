//
//  FeedVC.swift
//  SalesApp
//
//  Created by Mac-ninjaKID on 11/30/16.
//  Copyright © 2016 KobePham. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKCoreKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {

        // tapped SignOut
        var singleTapped = UITapGestureRecognizer(target: self, action: Selector("tapDetected"))
        singleTapped.numberOfTapsRequired = 1 // you can change this value
        signOutTapped.isUserInteractionEnabled = true
        signOutTapped.addGestureRecognizer(singleTapped)

        tableView.delegate = self
        tableView.dataSource = self
    }


    @IBOutlet weak var signOutTapped: UIImageView!

    func tapDetected() {
        let keyChainResult = KeychainWrapper.removeObjectForKey(KEY_UID)
        print ("JESS: ID removed Keychain \(keyChainResult)")
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("JESS: Error signing out Firebase \(signOutError)")
        }
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
}
