//
//  OwnedItem.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/11/05.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

struct OwnedItem: Codable{
    var negi: Int
    var okura: Int
    var sirasu: Int
    
    func createItemList()->[ToppingSelectCollectionViewCell.ViewModel] {
        var toppings: [ToppingSelectCollectionViewCell.ViewModel] = []
        
        if negi != 0 {
            toppings.append(ToppingSelectCollectionViewCell.ViewModel(image: UIImage(named: "negi")!, count: negi,instance: Negi()))
        }
        if okura != 0 {
            toppings.append(ToppingSelectCollectionViewCell.ViewModel(image: UIImage(named: "okura")!, count: okura, instance: Okura()))
        }
        
        if sirasu != 0 {
            toppings.append(ToppingSelectCollectionViewCell.ViewModel(image: UIImage(named: "sirasu")!, count: sirasu, instance: Sirasu()))
        }
        
        return toppings
    }
}
