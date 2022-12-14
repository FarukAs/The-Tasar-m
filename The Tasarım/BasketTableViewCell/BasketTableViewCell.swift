//
//  BasketTableViewCell.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 12.12.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet var plusButton: UIButton!
    
    @IBOutlet var trashButton: UIButton!
    @IBOutlet var numberOfProduct: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
