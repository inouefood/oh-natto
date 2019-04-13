//
//  SKPhysicsBody+Addition.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/04/07.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody {
    func make(circleOfRadius: CGFloat, category: UInt32, contact: UInt32, isGravity: Bool) -> SKPhysicsBody {
        let body = SKPhysicsBody(circleOfRadius: circleOfRadius)
        body.categoryBitMask = category
        body.contactTestBitMask = contact
        body.affectedByGravity = isGravity
        return body
    }
    func make(circleOfRadius: CGFloat, isGravity: Bool)  -> SKPhysicsBody {
        let body = SKPhysicsBody(circleOfRadius: circleOfRadius)
        body.affectedByGravity = isGravity
        return body
    }
    func make(rectangleOf: CGSize, category: UInt32, contact: UInt32, isGravity: Bool) -> SKPhysicsBody {
        let body = SKPhysicsBody(rectangleOf: rectangleOf)
        body.categoryBitMask = category
        body.contactTestBitMask = contact
        body.affectedByGravity = isGravity
        return body
    }
}
