//
//  SKSpriteNode+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/02.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    // initializer for MixScene
    convenience init(image: String, pos: CGPoint, body: SKPhysicsBody, category: UInt32, contact: UInt32, isGravity: Bool) {
        self.init(imageNamed: image)
        self.position = pos
        self.physicsBody = body
        self.physicsBody?.categoryBitMask = category
        self.physicsBody?.contactTestBitMask = contact
        self.physicsBody!.affectedByGravity = isGravity
    }
    // initializer for PullNattoScene
    convenience init(image: String, pos: CGPoint, body: SKPhysicsBody, isGravity: Bool) {
        self.init(imageNamed: image)
        self.position = pos
        self.physicsBody = body
        self.physicsBody!.affectedByGravity = isGravity
    }
}
