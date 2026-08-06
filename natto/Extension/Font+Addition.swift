//
//  Font+Addition.swift
//  natto
//

import SwiftUI

extension Font {
    // iPhone 14/15 の標準幅 390pt を基準にスケール
    static var fontScale: CGFloat {
        UIScreen.main.bounds.width / 390
    }

    static func scaled(_ size: CGFloat, weight: Weight = .regular) -> Font {
        .system(size: size * fontScale, weight: weight)
    }

    static func scaledCustom(_ name: String, size: CGFloat) -> Font {
        .custom(name, size: size * fontScale)
    }
}
