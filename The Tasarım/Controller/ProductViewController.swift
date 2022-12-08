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
    let db = Firestore.firestore()
    var selectedlabel = ""
    var selectedimage = ""
    var selectedinformation = ""
    var selectedprice = Int(0)
    var selectednumber = Int(0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBasketButton.layer.cornerRadius = 18
        addBasketButton.layer.shadowColor = UIColor.black.cgColor
        addBasketButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addBasketButton.layer.shadowRadius = 10
        addBasketButton.layer.shadowOpacity = 0.3
        
        informationLabel.numberOfLines = 0
        informationLabel.sizeToFit()
        selam.likeArray = []
        print(selectednumber)
        labelone.text = selectedlabel
        priceLabel.text = "\(selectedprice) TL"
        informationLabel.text = selectedinformation
        URLSession.shared.dataTask(with: URL(string: selectedimage)!) { (data, response, error) in
         
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              self.imageView.image = UIImage(data: imageData)
          }
        }.resume()
        
        let docRef = db.collection("likedNumber").document("LA")
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                selam.likeArray = dataDescription?["number"] as! Array
                selam.likeArray.append(selectednumber)
                print(selam.likeArray)
            } else {
                print("Document does not exist")
            }
        }
    }
    

    @IBAction func likeButton(_ sender: UIButton) {
        likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self!.db.collection("likedNumber").document("LA").setData([
                "number" : selam.likeArray
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    print(selam.likeArray)
                    
                }
            }
            }
        print(selam.likeArray)
 
    }
    @IBAction func speetbut(_ sender: UIButton) {
        
        /*
        let docRef = db.collection("likedNumber").document("LA")
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                safeData = dataDescription?["number"] as! Array
                print(safeData)
            } else {
                print("Document does not exist")
            }
        }
        */
    }
}
