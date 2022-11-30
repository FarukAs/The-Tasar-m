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
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in if let e = error {
                print(e)
            } else {
                self.performSegue(withIdentifier: "loginToAccountVC", sender: nil)
                return
            }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonOutlet.layer.cornerRadius = 18
        loginButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        loginButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButtonOutlet.layer.shadowRadius = 10
        loginButtonOutlet.layer.shadowOpacity = 0.3
        self.hideKeyboardWhenTappedAround()
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in if let e = error {
                print(e) } else {
                    self.performSegue(withIdentifier: "", sender: self)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self!.loginButtonOutlet.isSelected = false
        }
        self.loginButtonOutlet.isSelected = true
        print("hit")
        return true
    }
}

