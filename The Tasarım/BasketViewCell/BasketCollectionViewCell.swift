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
    
    var inbasket = false
    override func awakeFromNib() {
        super.awakeFromNib()
        addToBasketOutlet.layer.cornerRadius = 18
        
    }
}
