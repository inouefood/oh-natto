//
//  ToppingSelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ToppingSelectViewController: UIViewController {
    //TODO 本番用のアイテムを入れる
    let mockTopping = [
        ToppingSelectCollectionViewCell.ViewModel(image: UIImage(named: "negi")!, count: 3),
        ToppingSelectCollectionViewCell.ViewModel(image: UIImage(named: "okura")!, count: 3),
                                                  ToppingSelectCollectionViewCell.ViewModel(image: UIImage(named: "sirasu")!, count: 3)]
    
    
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
    @IBOutlet weak var firstToppingImage: UIImageView!
    @IBOutlet weak var secondToppingImage: UIImageView!
    @IBOutlet weak var thirdToppingImage: UIImageView!
    
    var decisionAction: (()->())?
    
    @IBOutlet weak var decisionButton: UIButton! {
        didSet {
            decisionButton.setTitle("けってい", for: .normal)
        }
    }
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.setTitle("リセット", for: .normal)
        }
    }
    
    var selectHandler: (([Topping])->Void)?
    private var selectTopping:[Topping] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = .orange
    }
    
    @IBAction func decisionAction(_ sender: Any) {
        decisionAction?()
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
        return mockTopping.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToppingSelectCollectionViewCell", for: indexPath) as! ToppingSelectCollectionViewCell
        cell.viewModel = mockTopping[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO 選択された際にセルのカウント情報を書き換える
        if firstToppingImage.image == nil {
            if indexPath.row == 0 {
                firstToppingImage.image = mockTopping[indexPath.row].image
                //TODO ここがべた書きになってしまっているのでcellから取得して良い感じに判定できるようにする
                selectTopping.append(Negi())
            } else if indexPath.row == 1 {
                firstToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Okura())
            } else {
                firstToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Sirasu())
            }
            selectHandler?(selectTopping)
            
        } else if thirdToppingImage.image == nil {
            if indexPath.row == 0 {
                thirdToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Negi())
            } else if indexPath.row == 1 {
                thirdToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Okura())
            } else {
                thirdToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Sirasu())
            }
            selectHandler?(selectTopping)
        } else if secondToppingImage.image == nil {
            if indexPath.row == 0 {
                secondToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Negi())
            } else if indexPath.row == 1 {
                secondToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Okura())
            } else {
                secondToppingImage.image = mockTopping[indexPath.row].image
                selectTopping.append(Sirasu())
            }
            selectHandler?(selectTopping)
        } else {
            showInformation(message: "トッピングは3個まで使用することができます",
                            closeButtonText: localizeString(key: LocalizeKeys.UpdateLeast.buttonClose))
        }
    }
}
