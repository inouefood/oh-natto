//
//  OwnedItem.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/11/05.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
typealias ToppingCellViewModel = ToppingSelectCollectionViewCell.ViewModel

struct OwnedItem: Codable{
    var negi: Int
    var okura: Int
    var sirasu: Int
    
    func createItemList(alreadySelect: [Topping])->[ToppingSelectCollectionViewCell.ViewModel] {
        var toppings: [ToppingSelectCollectionViewCell.ViewModel] = []
        var alreadySelectNegiCount = 0
        var alreadySelectOkuraCount = 0
        var alreadySelectSirasuCount = 0
        
        alreadySelect.forEach{
            switch $0.type {
            case .negi:
                alreadySelectNegiCount += 1
            
            case .okura:
                alreadySelectOkuraCount += 1
            
            case .sirasu:
                alreadySelectSirasuCount += 1
            }
        }
        
        if negi != 0 {
            toppings.append(ToppingCellViewModel(image: UIImage(named: "negi")!,
                                                 count: negi - alreadySelectNegiCount,
                                                 instance: Negi()))
        }
        if okura != 0 {
            toppings.append(ToppingCellViewModel(image: UIImage(named: "okura")!,
                                                 count: okura - alreadySelectOkuraCount,
                                                 instance: Okura()))
        }
        
        if sirasu != 0 {
            toppings.append(ToppingCellViewModel(image: UIImage(named: "sirasu")!,
                                                 count: sirasu - alreadySelectSirasuCount,
                                                 instance: Sirasu()))
        }
        
        return toppings
    }
}
