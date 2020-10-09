//
//  ShareButton.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/09.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

@IBDesignable
class ShareButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttribute()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAttribute()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupAttribute()
    }

    func setupAttribute() {
        layer.cornerRadius = frame.height / 2
        backgroundColor = .gray
        setImage(UIImage(named: "share")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
