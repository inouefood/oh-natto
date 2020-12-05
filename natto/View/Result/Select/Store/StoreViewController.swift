//
//  StoreViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/11.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    private let toppingArr:[Topping] = [Negi(), Okura(), Sirasu()]

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "StoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoreCollectionViewCell")
            
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            collectionView.collectionViewLayout = layout
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

//    @IBAction func buyAction(_ sender: Any) {
//        showInformation(title: "購入", message: " ネギを納豆と交換しますか？", yesButtonText: "はい", closeButtonText: "やめる") {
//            let eatKey = "natto"
//            guard let eatPoint = UserStore.eatPoint,
//                  var nattoPoint = eatPoint[eatKey] else {
//                return
//            }
//            nattoPoint -= 30
//            UserStore.eatPoint?.updateValue(nattoPoint, forKey: eatKey)
//
//
//            //アイテム購入
//            guard var item = UserStore.ownedItem else {
//                let item = OwnedItem(negi: 1, okura: 0, sirasu: 0)
//                UserStore.ownedItem = item
//                return
//            }
//
//            item.negi += 1
//            UserStore.ownedItem = item
//
//        }
//    }
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension StoreViewController: UICollectionViewDelegate {
    
}

extension StoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toppingArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCollectionViewCell", for: indexPath) as! StoreCollectionViewCell
        cell.imageView.image = UIImage(named: "negi")

        return cell
    }
}
