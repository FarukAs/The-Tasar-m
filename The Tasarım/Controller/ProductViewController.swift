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
    override func viewDidLoad() {
        super.viewDidLoad()
        addBasketButton.layer.cornerRadius = 18
        addBasketButton.layer.shadowColor = UIColor.black.cgColor
        addBasketButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addBasketButton.layer.shadowRadius = 10
        addBasketButton.layer.shadowOpacity = 0.3
        informationLabel.numberOfLines = 0
        informationLabel.sizeToFit()
        print(selectednumber)
        labelone.text = selectedlabel
        priceLabel.text = "\(selectedprice) TL"
        informationLabel.text = selectedinformation
        
        for item1 in selam.likeArray {
            if selectednumber == item1 {
                likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        
        URLSession.shared.dataTask(with: URL(string: selectedimage)!) { (data, response, error) in
         
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              self.imageView.image = UIImage(data: imageData)
          }
        }.resume()
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
