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
    let db = Firestore.firestore()
    override func viewDidLoad() {
        myNewContentArray = []
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        let docRef = db.collection("likedNumber").document("LA")
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                selam.likeArray = dataDescription?["number"] as! Array
                print(selam.likeArray)
            } else {
                print("Document does not exist")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self!.getdoc()
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

        
 
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberr = Int(3)
        return numberr
    }
}
