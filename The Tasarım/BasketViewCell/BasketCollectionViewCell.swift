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
        addToBasketOutlet.layer.shadowColor = UIColor.black.cgColor
        addToBasketOutlet.layer.shadowOffset = CGSize(width: 2, height: 2)
        addToBasketOutlet.layer.shadowRadius = 10
        addToBasketOutlet.layer.shadowOpacity = 0.3
    }

    @IBAction func addToBasket(_ sender: UIButton) {
        print("selectdbasket")
    }
}
