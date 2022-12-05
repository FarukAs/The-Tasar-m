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
    let number : Int
    let category: String
    
    init(image: String, label: String ,information: String , price:Int,number:Int, category: String) {
        self.image = image
        self.label = label
        self.information = information
        self.price = price
        self.number = number
        self.category = category
    }
}
struct selam {
    static var sellimage = ""
    static var selllabel = ""
    static var sellinformation = ""
    static var sellprice = Int(0)
    static var sellnumber = Int(0)
}


