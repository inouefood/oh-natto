//
//  SKShapeNode+Addition.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/04/20.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
    convenience init(path: CGMutablePath, color: UIColor, lineWid: CGFloat, alpha: CGFloat, zPos: CGFloat, isInteractive: Bool) {
        self.init(path: path)
        self.strokeColor = color
        self.lineWidth = lineWid
        self.alpha = alpha
        self.zPosition = zPos
        self.isUserInteractionEnabled = isInteractive
    }
}
