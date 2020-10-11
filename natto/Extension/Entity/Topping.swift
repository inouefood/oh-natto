//
//  Topping.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/11.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

protocol Topping {
    var type: ToppingType { get }
    var quantity: Int {get}
    var point: Int {get}
    var imageName: String {get}
}

enum ToppingType {
    case negi
    case okura
    case sirasu
}

class Negi: Topping {
    var type: ToppingType {
        return .negi
    }
    
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

class Okura: Topping {
    var type: ToppingType {
        return .okura
    }
    
    var imageName: String {
        return "okura"
    }
    
    var quantity: Int {
        return 10
    }
    
    var point: Int {
        return 5
    }
}

class Sirasu: Topping {
    var type: ToppingType {
        return .sirasu
    }
    
    var imageName: String {
        return "sirasu"
    }
    
    var quantity: Int {
        return 10
    }
    
    var point: Int {
        return 10
    }
}
