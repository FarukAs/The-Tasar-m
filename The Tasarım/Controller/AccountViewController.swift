//
//  AccountViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 29.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class AccountViewController: UIViewController {


    @IBAction func button(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var user = Auth.auth().currentUser?.email
        if Auth.auth().currentUser != nil {
            print("user signed in\(user)")
        }

    }
    

}
