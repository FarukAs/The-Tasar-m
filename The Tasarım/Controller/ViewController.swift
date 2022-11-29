//
//  ViewController.swift
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

class ViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var thirdView: UIView!
    @IBOutlet var fourthView: UIView!
    @IBOutlet var sixthView: UIView!
    @IBOutlet var seventhView: UIView!
    @IBOutlet var eighthView: UIView!
    @IBOutlet var ninthView: UIView!
    @IBOutlet var fifthView: UIView!
    @IBOutlet var tenthView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        views(viewdesign: firstView)
        views(viewdesign: secondView)
        views(viewdesign: thirdView)
        views(viewdesign: fourthView)
        views(viewdesign: fifthView)
        views(viewdesign: sixthView)
        views(viewdesign: seventhView)
        views(viewdesign: eighthView)
        views(viewdesign: ninthView)
        views(viewdesign: tenthView)
        self.hideKeyboardWhenTappedAround()
        
        

        
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReusableCell")
    }
    @IBAction func accountButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    
    
    func views(viewdesign: UIView) {
        viewdesign.layer.cornerRadius = 18
        viewdesign.layer.shadowColor = UIColor.black.cgColor
        viewdesign.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewdesign.layer.shadowRadius = 10
        viewdesign.layer.shadowOpacity = 0.3
    }
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return View.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableCell", for: indexPath as IndexPath) as! CollectionViewCell
        
        cell.label.text = "\(View[indexPath.item].label)"
        cell.imageView.image = UIImage(named: "\(View[indexPath.item].image)")

        cell.layer.cornerRadius = 5.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
            print("You selected cell #\(indexPath.item)!")
        }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

