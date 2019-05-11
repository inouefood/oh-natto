//
//  ObjectPosition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/14.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import UIKit

struct ObjectPosition: Equatable {
    let x: Float
    let y: Float
    
    init(x:Float, y: Float) {
        self.x = x
        self.y = y
    }
    init(pos: CGPoint) {
        self.x = Float(pos.x)
        self.y = Float(pos.y)
    }
    static func ==(lhs: ObjectPosition, rhs: ObjectPosition) -> Bool{
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
