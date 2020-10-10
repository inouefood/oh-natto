//
//  Topping.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/11.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

protocol Topping {
    var quantity: Int {get}
    var point: Int {get}
    var imageName: String {get}
}

class Negi: Topping {
    var imageName: String {
        return "negi"
    }
    
    var quantity: Int {
        return 10
    }
    
    var point: Int {
        return 3
    }
    
}
