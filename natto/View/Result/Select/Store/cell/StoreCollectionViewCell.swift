//
//  StoreCollectionViewCell.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/12/05.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
