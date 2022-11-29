//
//  LoginViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 29.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let signInConfig = GIDConfiguration(clientID: "918468520308-anbuv7i2dch9e7ddubdjth44ileffr3e.apps.googleusercontent.com")

    override func viewDidLoad() {
  
        super.viewDidLoad()
    }
    @IBAction func loginButton(_ sender: UIButton) {
    }
    GIDSignIn.sharedInstance.signIn(
      with: signInConfig,
      presenting: self) { user, error in
        guard  error == nil else {
          return
        }
        // If sign in succeeded, display the app's main content View.
      }
 
}
