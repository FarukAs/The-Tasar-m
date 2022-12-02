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
    
    init(image: String, label: String ,information: String , price:Int) {
        self.image = image
        self.label = label
        self.information = information
        self.price = price
    }
}
struct selam {
    static var sellimage = ""
    static var selllabel = ""
    static var sellinformation = ""
    static var sellprice = Int(0)
}
