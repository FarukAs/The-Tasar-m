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
    override func viewDidLoad() {
        myNewContentArray = []
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell" , for: indexPath) as! TableViewCell
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
}
