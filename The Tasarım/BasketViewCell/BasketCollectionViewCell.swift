//
//  BasketCollectionViewCell.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 12.12.2022.
//

import UIKit

class BasketCollectionViewCell: UICollectionViewCell {

    @IBOutlet var addToBasketOutlet: UIButton!
    @IBOutlet var view: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        addToBasketOutlet.layer.cornerRadius = 18
        
    }

    @IBAction func addToBasket(_ sender: UIButton) {
        if addToBasketOutlet.titleLabel!.text == "Sepete ekle" {
            UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                    sender.setTitle("Sepete eklendi", for: .normal)
                }, completion: nil)
        }
    }
}
