//
//  ProductViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 1.12.2022.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet var labelone: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedlabel = ""
    var selectedimage = UIImage(named: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelone.text = selectedlabel
        imageView.image = selectedimage
        print(selectedlabel)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
