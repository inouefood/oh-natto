//
//  Closebutton.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/13.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

@IBDesignable
class CloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupAttributes()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupAttributes()
    }
    
    private func setupAttributes() {
        backgroundColor = .clear
        setImage(UIImage(named: "close")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
