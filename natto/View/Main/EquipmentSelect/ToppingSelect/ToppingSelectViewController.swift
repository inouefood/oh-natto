//
//  ToppingSelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ToppingSelectViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
            collectionView.register(UINib(nibName: "ToppingSelectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToppingSelectCollectionViewCell")
            
            
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            collectionView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var firstToppingImage: UIImageView! {
        didSet {
            firstToppingImage.layer.cornerRadius = firstToppingImage.frame.width/2
        }
    }
    @IBOutlet weak var secondToppingImage: UIImageView!{
        didSet {
            secondToppingImage.layer.cornerRadius = secondToppingImage.frame.width/2
        }
    }
    @IBOutlet weak var thirdToppingImage: UIImageView!{
        didSet {
            thirdToppingImage.layer.cornerRadius = thirdToppingImage.frame.width/2
        }
    }
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.layer.cornerRadius = 6
            resetButton.setTitle("リセット", for: .normal)
        }
    }
    var selectHandler: (([Topping])->Void)?
    private var selectTopping:[Topping] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = .orange
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //TODO ここで選択されたものを表示するようにする
        if firstToppingImage.image == nil {
            selectTopping.append(Negi())
            firstToppingImage.image = UIImage(named: "negi")
        } else if secondToppingImage.image == nil {
            selectTopping.append(Negi())
            secondToppingImage.image = UIImage(named: "negi")
        } else {
            selectTopping.append(Negi())
            thirdToppingImage.image = UIImage(named: "negi")
        }
        selectHandler?(selectTopping)

    }
    
    @IBAction func resetAction(_ sender: Any) {
        firstToppingImage.image = nil
        secondToppingImage.image = nil
        thirdToppingImage.image = nil
        
        selectTopping = []
        selectHandler?(selectTopping)
    }
}

extension ToppingSelectViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToppingSelectCollectionViewCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let horizontalSpace : CGFloat = 20
            let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
            return CGSize(width: cellSize, height: cellSize)
        }
}
