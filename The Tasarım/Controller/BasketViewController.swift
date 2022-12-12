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
    
    var inBasket = [0]
    
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
        print(collectionView.frame)

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
    func collectionviewayarlayacam() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10 // hücreler arasındaki minimum boşluk
        flowLayout.minimumInteritemSpacing = 10 // hücrelerin yan yana olması durumunda aralarındaki minimum boşluk
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 0) // hücrelerin collection view'ın içerisindeki konumlarına göre boşlukları

        // hücrelerin boyutunu ayarlama
        flowLayout.estimatedItemSize = CGSize(width: 150, height: 315)
        flowLayout.scrollDirection = .vertical
        collectionView.backgroundColor = .blue
        // collection view'ımıza flow layout'ı atama
        collectionView.collectionViewLayout = flowLayout
        collectionView.frame.size = flowLayout.collectionViewContentSize
        collectionView.isScrollEnabled = true
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
