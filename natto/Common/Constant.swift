//
//  Common.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/14.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation

struct Constant {
    struct SpriteCount {
        static let natto = 500
    }
    struct Sticky {
        static let level: Float = 0.0005
    }
    struct CollisionBody {
        static let ohashi: UInt32 =  0x1 << 0
        static let natto: UInt32 = 0x1 << 1
    }
}
