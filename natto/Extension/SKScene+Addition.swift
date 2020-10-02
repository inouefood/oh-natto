//
//  SKScene+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/29.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKScene {
    func addChild(_ nodes: SKNode...) {
        nodes.forEach{addChild($0)}
    }
    
    func screenRandomPos() -> CGPoint {
        return CGPoint(x: randX, y: randY)
    }
    
    var randX: CGFloat {
        get {
            return CGFloat.random(in: 0...self.frame.size.width)
        }
    }
    var randY: CGFloat {
        get {
            return CGFloat.random(in: 0...self.frame.size.height)
        }
    }
    var width: CGFloat {
        get {
            return frame.width
        }
    }
    var height: CGFloat {
        get {
            return frame.height
        }
    }
}
