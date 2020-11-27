//
//  ToppingSelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ToppingManager: NSObject {
    var selectedItem:[Topping] = []

    static let shared: ToppingManager = ToppingManager()
    private override init() {}
}

class ToppingSelectViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var decisionButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var firstToppingImage: UIImageView!
    @IBOutlet weak var secondToppingImage: UIImageView!
    @IBOutlet weak var thirdToppingImage: UIImageView!
    
    var decisionAction: (()->())?
    var toppings:[ToppingSelectCollectionViewCell.ViewModel] = []
    
    override func viewDidLoad() {
        ToppingManager.shared.selectedItem.forEach{
            setImage(image: $0.type.image)
        }
        commonInit()
    }
    
    @IBAction func decisionAction(_ sender: Any) {
        decisionAction?()
    }
    
    @IBAction func resetAction(_ sender: Any) {
        ToppingManager.shared.selectedItem = []
        firstToppingImage.image = nil
        secondToppingImage.image = nil
        thirdToppingImage.image = nil
    }
    
    private func setImage(image: UIImage?) {
        if firstToppingImage.image == nil {
            firstToppingImage.image = image
          
        } else if thirdToppingImage.image == nil {
            thirdToppingImage.image = image
    
        } else if secondToppingImage.image == nil {
            secondToppingImage.image = image
            
        }
    }
    
    private func commonInit(){
        resetButton.setTitle(localizeString(key: LocalizeKeys.ToppingSelect.reset), for: .normal)
        decisionButton.setTitle(localizeString(key: LocalizeKeys.ToppingSelect.decision), for: .normal)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName: "ToppingSelectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToppingSelectCollectionViewCell")
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
}

extension ToppingSelectViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toppings.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToppingSelectCollectionViewCell", for: indexPath) as! ToppingSelectCollectionViewCell
        cell.viewModel = toppings[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO 選択された際にセルのカウント情報を書き換える
        let cell = collectionView.cellForItem(at: indexPath) as! ToppingSelectCollectionViewCell
        let count = Int(cell.toppingCountLabel.text!)! - 1
        if count < 0 {
            showInformation(message: localizeString(key: LocalizeKeys.ToppingSelect.alertItemLess),
                            closeButtonText: localizeString(key: LocalizeKeys.UpdateLeast.buttonClose))
            return
        }
        cell.toppingCountLabel.text = count.description
        
        if firstToppingImage.image == nil {
            setImage(image: toppings[indexPath.row].instance.type.image)
            ToppingManager.shared.selectedItem.append(toppings[indexPath.row].instance)
            
        } else if thirdToppingImage.image == nil {
            setImage(image: toppings[indexPath.row].instance.type.image)
            ToppingManager.shared.selectedItem.append(toppings[indexPath.row].instance)
            
        } else if secondToppingImage.image == nil {
            setImage(image: toppings[indexPath.row].instance.type.image)
            ToppingManager.shared.selectedItem.append(toppings[indexPath.row].instance)
            
        } else {
            showInformation(message: localizeString(key:LocalizeKeys.ToppingSelect.alertSelectOver),
                            closeButtonText: localizeString(key: LocalizeKeys.UpdateLeast.buttonClose))
        }
    }
}
