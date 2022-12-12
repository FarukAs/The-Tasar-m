//
//  BasketViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 11.12.2022.
//

import UIKit

class BasketViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "liked") as? [Int] {
            selam.likeArray = item
        }
        myNewContentArray = []
        getdoc()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BasketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BasketReusableCell")
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myNewContentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketReusableCell", for: indexPath as IndexPath) as! BasketCollectionViewCell
        URLSession.shared.dataTask(with: URL(string: myNewContentArray[indexPath.item].image)!) { (data, response, error) in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: imageData)
            }
        }.resume()
        
        cell.label.text = myNewContentArray[indexPath.item].label
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        print(myNewContentArray)
    }
}
