//
//  BasketViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 11.12.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class BasketViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    var totalPrice = Int(0)
    var myVar = Int()
    let currentEmail = AccountViewController().user
    @IBOutlet var firstView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var topSecondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("xxxz\(String(describing: currentEmail))")
        if let item = defaults.array(forKey: "basket") as? [Int] {
            selam.basketArray = item
        }
        if selam.basketArray == [99999] || selam.basketArray == []  {
            topSecondView.isHidden = true
        }else {
            topView.isHidden = true
        }
        myNewContentArray = []
        basket = []
        findMatchingContent()
        getlike()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BasketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BasketReusableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        for na in selam.basketArray {
            for nam in View{
                if na == nam.number {
                    for namb in selam.productNumber {
                        if namb.key ==  "\(na)" {
                            myVar += namb.value * nam.price
                        }
                    }
                }
            }
        }
        self.totalPriceLabel.text = "\(myVar) TL"
    }
    func getlike() {
        for number in selam.basketArray {
            for mynumber in View {
                if number == mynumber.number {
                    basket.append(mynumber)
                }
            }
        }
    }
    func findMatchingContent() {
        let likeSet = Set(selam.likeArray)
        let basketSet = Set(selam.basketArray)
      let difference = likeSet.subtracting(basketSet)

      for number in difference {
        for content in View {
          if content.number == number {
            myNewContentArray.append(content)
            break
          }
        }
      }
    }
    @IBAction func confirmButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Başarılı", message: "Sepetin onaylandı.", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myNewContentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketReusableCell", for: indexPath as IndexPath) as! BasketCollectionViewCell
        cell.addToBasketOutlet.addTarget(self, action: #selector(basketOutlet(sender:)), for: .touchUpInside)
        cell.addToBasketOutlet.tag = indexPath.row
        URLSession.shared.dataTask(with: URL(string: myNewContentArray[indexPath.item].image)!) { (data, response, error) in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: imageData)
            }
        }.resume()
        
     
        
        
        cell.label.text = myNewContentArray[indexPath.item].label
        return cell
    }
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        // İşlemlerinizi burada yapın
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected\(indexPath.item)")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell" , for: indexPath) as! BasketTableViewCell
        URLSession.shared.dataTask(with: URL(string: basket[indexPath.item].image)!) { (data, response, error) in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                cell.imageview.image = UIImage(data: imageData)
            }
        }.resume()
        cell.priceLabel.text = "\(basket[indexPath.item].price) TL"
        cell.label.text = basket[indexPath.item].label
        
        cell.plusButton.addTarget(self, action: #selector(plusButton(sender:)), for: .touchUpInside)
        cell.plusButton.tag = indexPath.row
        cell.trashButton.addTarget(self, action: #selector(trashButton(sender:)), for: .touchUpInside)
        cell.trashButton.tag = indexPath.row
        

   
        let labelNumber = selam.productNumber["\(basket[indexPath.item].number)"]!
        if labelNumber > 1 {
                cell.trashButton.setImage(UIImage(systemName: "minus"), for: .normal)
        } else {
                cell.trashButton.setImage(UIImage(systemName: "trash"), for: .normal)
        }
        
        cell.numberOfProduct.text =  "\(selam.productNumber["\(basket[indexPath.item].number)"]!)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    @objc func plusButton(sender: UIButton){
        let buttonTag = sender.tag

        selam.productNumber["\(basket[buttonTag].number)"]! += 1
        do {
            try db.collection("cities").document(currentEmail!).setData(selam.productNumber)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        tableView.reloadData()
    }
    @objc func trashButton(sender: UIButton){
        let buttonTag = sender.tag
        if selam.productNumber["\(basket[buttonTag].number)"]! > 1 {
            selam.productNumber["\(basket[buttonTag].number)"]! -= 1
        } else {
            selam.basketArray.removeAll(where: { $0 == basket[buttonTag].number })
            defaults.set(selam.basketArray, forKey: "basket")
        }
        do {
            try db.collection("cities").document(currentEmail!).setData(selam.productNumber)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        tableView.reloadData()
    }
    @objc func basketOutlet(sender: UIButton){
        let buttonTag = sender.tag
        
    }
}

