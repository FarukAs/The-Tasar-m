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
    
    @IBOutlet var logOutButtonOutlet: UIButton!
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser?.email
    @IBOutlet var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        if Auth.auth().currentUser != nil {
            print("user signed in\(user!)")
            
            logOutButtonOutlet.layer.cornerRadius = 18
            logOutButtonOutlet.layer.shadowColor = UIColor.black.cgColor
            logOutButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
            logOutButtonOutlet.layer.shadowRadius = 10
            logOutButtonOutlet.layer.shadowOpacity = 0.3
            
            
            db.collection("username").addSnapshotListener() { (querySnapshot, err) in
                if let e = err {
                    print(e)
                } else {
                    for doc in querySnapshot!.documents {
                        let data = doc.data()
                        if let username = data["username"] , let email = data["email"] {
                            if email as! String? == Auth.auth().currentUser?.email as String?  {
                                self.usernameLabel.text = "\(username)"
                                print("sas\(email)")
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
