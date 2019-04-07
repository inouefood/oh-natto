//
//  SKSpriteNode+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/02.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    // initializer for MixScene/mame, ohashi
    convenience init(image: String, pos: CGPoint, body: SKPhysicsBody, category: UInt32, contact: UInt32, isGravity: Bool) {
        self.init(imageNamed: image)
        self.position = pos
        self.physicsBody = body
        self.physicsBody?.categoryBitMask = category
        self.physicsBody?.contactTestBitMask = contact
        self.physicsBody!.affectedByGravity = isGravity
    }
    // initializer for PullNattoScene/mame
    convenience init(image: String, pos: CGPoint, body: SKPhysicsBody, isGravity: Bool) {
        self.init(imageNamed: image)
        self.position = pos
        self.physicsBody = body
        self.physicsBody!.affectedByGravity = isGravity
    }
    // initializer for PullNattoScene/mouth
    convenience init(image: String, viewBounds: CGRect, frame: CGRect, zPos: CGFloat) {
        self.init(imageNamed: image)
        let scale = viewBounds.width / self.size.width
        self.position = CGPoint(x: frame.midX, y: frame.maxY - (self.size.height * scale * 2.0) / 2.0)
        self.size = CGSize(width: frame.size.width, height: self.size.height * scale * 2.0)
        self.zPosition = zPos
    }
    // initializer for PullNattoScene/ohashi
    convenience init(image: String, pos: CGPoint, viewBounds: CGRect, frame: CGRect, zPos: CGFloat) {
        self.init(imageNamed: image)
        self.position = pos
        let scale = viewBounds.width / self.size.width
        self.size = CGSize(width: self.size.width * scale / 2.0, height: self.size.height * scale / 2.0)
        self.zPosition = zPos
    }
}
