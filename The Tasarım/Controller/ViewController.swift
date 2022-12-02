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
    
    let db = Firestore.firestore()
    /*var selecteditem : Int = 0
    var selllabel = ""
    var sellimage = UIImage(named: "")
*/
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
        
        collectionView.reloadData()
        
       /* db.collection("products").addSnapshotListener() { (querySnapshot, err) in
            if let e = err {
                print(e)
            } else {
                
                print(View.count)
                for doc in querySnapshot!.documents {
                    let data = doc.data()
                    if let image = data["image"] ,      let label = data["label"] {
                        
                        let mylabel = [label]
                        let myimage = [image]
                        View.append(Content(image: "\(myimage)", label:"\(mylabel)"))
                        
                        print(View)
                        print(View.count)
print("en son bu")
                    }
                }
            }
        }
        */
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReusableCell")
    }
    @IBAction func accountButton(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toAccountVC", sender: nil)
        } else {
            performSegue(withIdentifier: "toRegisterVC", sender: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)


        
    }
    override func viewDidAppear(_ animated: Bool) {
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


        URLSession.shared.dataTask(with: URL(string: View[indexPath.item].image)!) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              cell.imageView.image = UIImage(data: imageData)
          }
        }.resume()
      
        
        return cell
    }

    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self!.performSegue(withIdentifier: "mainToProductVC", sender: nil)
                }
            
            selam.selllabel = "\(View[indexPath.item].label)"
            selam.sellimage = "\(View[indexPath.item].image)"
            selam.sellinformation = "\(View[indexPath.item].information)"
            selam.sellprice = Int(View[indexPath.item].price)
 
        print("You selected cell #\(indexPath.item)!")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToProductVC" {
            let destinationVC = segue.destination as! ProductViewController
            destinationVC.selectedlabel = selam.selllabel
            destinationVC.selectedimage = selam.sellimage
            destinationVC.selectedinformation = selam.sellinformation
            destinationVC.selectedprice = selam.sellprice
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
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

