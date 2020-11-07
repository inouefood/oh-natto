//
//  UIImage+Addition.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/11/07.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

extension UIView {
    func convertToImage() -> UIImage {
       let imageRenderer = UIGraphicsImageRenderer.init(size: bounds.size)
        return imageRenderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
