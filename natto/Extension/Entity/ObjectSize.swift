//
//  ObjectSize.swift
//  natto
//
//  Created by 佐川晴海 on 2019/05/11.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

struct ObjectSize  {
    let width: Float
    let height: Float
    
    init(size: CGSize) {
        self.width = Float(size.width)
        self.height = Float(size.height)
    }
}
