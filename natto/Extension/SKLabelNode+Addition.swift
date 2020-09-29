//
//  SKLabelNode+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/03.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    convenience init(font:String = "Verdana-bold", fontSize: CGFloat, text: String){
        self.init()
        self.fontName = font
        self.fontSize = fontSize
        self.text = text
    }
    convenience init(font:String = "Verdana-bold", fontSize: CGFloat, text: String, pos: CGPoint){
        self.init()
        self.fontName = font
        self.fontSize = fontSize
        self.text = text
        self.position = pos
    }
}
