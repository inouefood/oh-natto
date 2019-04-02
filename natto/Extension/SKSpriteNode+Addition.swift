//
//  SKSpriteNode+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/02.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    convenience init(image: String, pos: CGPoint, body: SKPhysicsBody, category: UInt32, contact: UInt32) {
        self.init()
        self.texture = SKTexture(imageNamed: image)
        self.position = pos
        self.physicsBody = body
        self.physicsBody?.categoryBitMask = category
        self.physicsBody?.contactTestBitMask = contact
    }
}
