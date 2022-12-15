//
//  ProductViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 1.12.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
class ProductViewController: UIViewController {
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var labelone: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addBasketButton: UIButton!
    @IBOutlet var likeButtonOutlet: UIButton!
    let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    var selectedlabel = ""
    var selectedimage = ""
    var selectedinformation = ""
    var selectedprice = Int(0)
    var selectednumber = Int(0)
    var inBasket = false
    override func viewDidLoad() {
        super.viewDidLoad()
        addBasketButton.layer.cornerRadius = 18
        addBasketButton.layer.shadowColor = UIColor.black.cgColor
        addBasketButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addBasketButton.layer.shadowRadius = 10
        addBasketButton.layer.shadowOpacity = 0.3
        informationLabel.numberOfLines = 0
        informationLabel.sizeToFit()
        labelone.text = selectedlabel
        priceLabel.text = "\(selectedprice) TL"
        informationLabel.text = selectedinformation
        if let item = defaults.array(forKey: "basket") as? [Int] {
            selam.basketArray = item
        }
        print("şşş\(selam.basketArray)")
        for number in selam.basketArray {
            if number == selectednumber {
                addBasketButton.titleLabel!.text = "Sepete eklendi"
                inBasket = true
            }
        }
        for item1 in selam.likeArray {
            if selectednumber == item1 {
                likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        
        print(selectedimage)
        URLSession.shared.dataTask(with: URL(string: selectedimage)!) { (data, response, error) in
            
            guard let imageData = data else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }.resume()
    }
    @IBAction func addToBasket(_ sender: UIButton) {
        if inBasket == true {
            print(selam.basketArray)
            selam.basketArray.removeAll(where: { $0 == selectednumber })
            defaults.set(selam.basketArray, forKey: "basket")
            print(selam.basketArray)
            UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                sender.setTitle("Sepete ekle", for: .normal)
            }, completion: nil)
            inBasket = false
            selam.productNumber.removeValue(forKey: "\(selectednumber)")
            do {
                try db.collection("cities").document("LA").setData(selam.productNumber)
            } catch let error {
                print("Error writing city to Firestore: \(error)")
            }
        } else {
            selam.basketArray.append(selectednumber)
            let uniqueNumbers = Set(selam.basketArray)
            let numbersWithoutDuplicates = Array(uniqueNumbers)
            print("kayıt\(numbersWithoutDuplicates)")
            defaults.set(numbersWithoutDuplicates, forKey: "basket")
            UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                sender.setTitle("Sepete eklendi", for: .normal)
            }, completion: nil)
            inBasket = true
            selam.productNumber["\(selectednumber)"] = 1
            do {
                try db.collection("cities").document("LA").setData(selam.productNumber)
            } catch let error {
                print("Error writing city to Firestore: \(error)")
            }
            print("bb\(selam.productNumber)")
        }
        print(selectednumber)
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        if likeButtonOutlet.currentImage == UIImage(systemName: "heart") {
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            selam.likeArray.append(selectednumber)
            defaults.set(selam.likeArray, forKey: "liked")
            
            
        } else {
            likeButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            selam.likeArray.removeAll(where: { $0 == self.selectednumber })
            defaults.set(selam.likeArray, forKey: "liked")
        }
        
    }
    
}
