//
//  CGMutablePath+Addition.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/04/20.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import CoreGraphics

extension CGMutablePath {
    func make(start: CGPoint, end: CGPoint) -> CGMutablePath {
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)
        path.closeSubpath()
        return path
    }
}
