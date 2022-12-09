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
    
    @IBOutlet var categoryCollectionView: UICollectionView!
    let defaults = UserDefaults.standard
    var delegate: DataCollectionProtocol?
    var index: IndexPath?
    var category = Int(1)
    let db = Firestore.firestore()

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let likedArray = defaults.array(forKey: "liked") as? [Int] {
            selam.likeArray = likedArray
        } else {
            let likedArray: [Int] = []
            defaults.set(likedArray, forKey: "liked")
            selam.likeArray = likedArray
        }
        self.hideKeyboardWhenTappedAround()
        collectionView.reloadData()
        for element in View {
            if element.category == category {
                myView.remove(at: 0)
                myView.append(element)
            }else {
            }
        }
        myView.removeAll()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReusableCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryReusableCell")
        let itemCount = categoryCollectionView.numberOfItems(inSection: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self!.categoryCollectionView.allowsSelection = true
                    if itemCount > 0 {
                        self!.categoryCollectionView.selectItem(at: IndexPath(item: 2, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                    }else {
                        print("Error")
                    }
            }
        
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
    @IBAction func likeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "mainToLikeVC", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableCell", for: indexPath as IndexPath) as! CollectionViewCell
            
            cell.layer.cornerRadius = 5.0
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 5, height: 5)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 0.5
            cell.layer.masksToBounds = false
            URLSession.shared.dataTask(with: URL(string: myView[indexPath.item].image)!) { (data, response, error) in
              guard let imageData = data else { return }
              DispatchQueue.main.async {
                  cell.imageView.image = UIImage(data: imageData)
              }
            }.resume()

            cell.imageView.image = UIImage(named: "\(myView[indexPath.item].image)")
            cell.label.text = myView[indexPath.item].label
            return cell
        } else {
            let cellb = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryReusableCell", for: indexPath as IndexPath) as! CollectionViewCell
            cellb.contentView.layer.cornerRadius = 10.0
            cellb.contentView.layer.borderWidth = 1.0
            cellb.contentView.layer.borderColor = UIColor.clear.cgColor
            cellb.contentView.layer.masksToBounds = true

            cellb.layer.shadowColor = UIColor.lightGray.cgColor
            cellb.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cellb.layer.shadowRadius = 10.0
            cellb.layer.shadowOpacity = 1.0
            cellb.layer.masksToBounds = false
            cellb.layer.shadowPath = UIBezierPath(roundedRect: cellb.bounds, cornerRadius: cellb.contentView.layer.cornerRadius).cgPath
            cellb.layer.backgroundColor = UIColor.clear.cgColor
            
            cellb.imageView.image = UIImage(named: "\(Cat[indexPath.item].image)")
            cellb.label.text = Cat[indexPath.item].label
            
            return cellb
        }
        
    }
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return myView.count
        } else {
            return Cat.count
        }
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == self.collectionView {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    self!.performSegue(withIdentifier: "mainToProductVC", sender: nil)
                    }
                selam.selllabel = "\(myView[indexPath.item].label)"
                selam.sellimage = "\(myView[indexPath.item].image)"
                selam.sellinformation = "\(myView[indexPath.item].information)"
                selam.sellprice = Int(myView[indexPath.item].price)
                selam.sellnumber = Int(myView[indexPath.item].number)
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    myView.removeAll()
                    self!.category = indexPath.item
                    for element in View {
                        if element.category == self!.category {
                            myView.append(element)
                        }else {
                        }
                    }
                    self!.collectionView.reloadData()
                }
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToProductVC" {
            let destinationVC = segue.destination as! ProductViewController
            destinationVC.selectedlabel = selam.selllabel
            destinationVC.selectedimage = selam.sellimage
            destinationVC.selectedinformation = selam.sellinformation
            destinationVC.selectedprice = selam.sellprice
            destinationVC.selectednumber = selam.sellnumber
        }
        if segue.identifier == "mainToLikeVC" {
            let destinationVC = segue.destination as! LikeViewController
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
extension ViewController: DataCollectionProtocol{ 
    func deleteData(indx: Int) {
        View.remove(at: indx)
        collectionView.reloadData()
    }
}
protocol DataCollectionProtocol{
    func deleteData(indx: Int)
}

