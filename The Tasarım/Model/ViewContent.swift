//
//  ViewContent.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 29.11.2022.
//

import Foundation
import UIKit

struct Content {
    let image : String
    let label : String
    let information : String
    let price : Int
    let like: String
    let basket: String
    
    init(image: String, label: String ,information: String , price:Int, like: String, basket:String) {
        self.image = image
        self.label = label
        self.information = information
        self.price = price
        self.like = like
        self.basket = basket
    }
}
struct selam {
    static var sellimage = ""
    static var selllabel = ""
    static var sellinformation = ""
    static var sellprice = Int(0)
}
