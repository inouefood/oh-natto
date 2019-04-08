//
//  SKSpriteNode+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/02.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    // initializer for MixScene/ohashi
    convenience init(image: String, pos: CGPoint, body: SKPhysicsBody) {
        self.init(imageNamed: image)
        self.position = pos
        self.physicsBody = body
    }
    // initializer for MixScene&PullNattoScene/mame
    convenience init(image: String, pos: CGPoint, body: SKPhysicsBody, rotate: CGFloat) {
        self.init(imageNamed: image)
        self.position = pos
        self.physicsBody = body
        self.zRotation = rotate
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
