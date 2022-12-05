//
//  ProductViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 1.12.2022.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var labelone: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addBasketButton: UIButton!
    @IBOutlet var likeButtonOutlet: UIButton!
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
    }
    

    @IBAction func likeButton(_ sender: UIButton) {
        likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        UserDefaults.standard.set(selectednumber, forKey: "liked")
        print(selectednumber)

    }
}
