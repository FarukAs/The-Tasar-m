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
import GoogleSignInSwift

class LoginViewController: UIViewController , UITextFieldDelegate , UIApplicationDelegate   {
    
    
    @IBOutlet var loginButtonOutlet: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    print(authResult as Any)
                }
                
            }
        }
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
    }

