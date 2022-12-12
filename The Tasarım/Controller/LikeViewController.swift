//
//  LikeViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 6.12.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
class LikeViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    var selectedlabel = ""
    var selectedimage = ""
    var selectedinformation = ""
    var selectedprice = Int(0)
    var selectednumber = Int(0)
    override func viewDidLoad() {
        super.viewDidLoad()
        myNewContentArray = []
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TBReusableCell")
        if let item = defaults.array(forKey: "liked") as? [Int] {
            selam.likeArray = item
        }
        getdoc()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self!.tableView.reloadData()
        }
        
    }
    func getdoc() {
        for number in selam.likeArray {
            for mynumber in View {
                if number == mynumber.number {
                    myNewContentArray.append(mynumber)
                    print(mynumber)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TBReusableCell" , for: indexPath) as! TableViewCell
        cell.label.text = myNewContentArray[indexPath.item].label
        URLSession.shared.dataTask(with: URL(string: myNewContentArray[indexPath.item].image)!) { (data, response, error) in
            // Error handling...
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                cell.imageView!.image = UIImage(data: imageData)
            }
        }.resume()
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNewContentArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self!.performSegue(withIdentifier: "likeToProducstVC", sender: nil)
        }
        
        selam.selllabel = "\(myNewContentArray[indexPath.item].label)"
        selam.sellimage = "\(myNewContentArray[indexPath.item].image)"
        selam.sellinformation = "\(myNewContentArray[indexPath.item].information)"
        selam.sellprice = Int(myNewContentArray[indexPath.item].price)
        selam.sellnumber = Int(myNewContentArray[indexPath.item].number)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likeToProducstVC" {
            let destinationVC = segue.destination as! ProductViewController
            destinationVC.selectedlabel = selam.selllabel
            destinationVC.selectedimage = selam.sellimage
            destinationVC.selectedinformation = selam.sellinformation
            destinationVC.selectedprice = selam.sellprice
            destinationVC.selectednumber = selam.sellnumber
        }
    }
}
