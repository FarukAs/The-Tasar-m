//
//  RegisterViewController.swift
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

class RegisterViewController: UIViewController , UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    
    @IBOutlet var userinfo: UITextField!
    @IBOutlet var registerButtonOutlet: UIButton!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButtonOutlet.layer.cornerRadius = 18
        registerButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        registerButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        registerButtonOutlet.layer.shadowRadius = 10
        registerButtonOutlet.layer.shadowOpacity = 0.3
        self.hideKeyboardWhenTappedAround()
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
    }
    @IBAction func registerButton(_ sender: UIButton) {
        let username = userinfo.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if let email = emailTextField.text , let password = passwordTextField.text , let username = self.userinfo.text , username != "" {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    
                } else {
                    if let username = self.userinfo.text ,let email = Auth.auth().currentUser?.email   {
                        self.db.collection("username").addDocument(data: [
                            "email" : email ,
                            "username" :username
                        ]) { err in
                            if let e = err {
                                print("burası\(e)")
                            } else {
                                print("Succesfully")
                            }
                        }
                    }
                    
                    self.performSegue(withIdentifier: "registerToAccountVC", sender: nil)
                }
            }
        } else if username == "" {
            print("username gir")
            //burası username.text boşsa verilecek alert button
        }; if email == "" {
            print("email giriniz")
        }; if password == "" {
            print("şifre giriniz")
        }
        
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
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in if let e = error {
                print(e)     } else {
                    self.performSegue(withIdentifier: "", sender: self)
                    
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self!.registerButtonOutlet.isSelected = false
        }
        self.registerButtonOutlet.isSelected = true
        self.hideKeyboardWhenTappedAround()
        print("tapped")
        return true
    }
}
