//
//  ToppingSelectCollectionViewCell.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/25.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ToppingSelectCollectionViewCell: UICollectionViewCell {
    struct ViewModel {
        var image: UIImage
        var count: Int
        var instance: Topping
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            toppingCountLabel.text = viewModel.count.description
            toppingImage.image = viewModel.image
        }
    }

    @IBOutlet weak var toppingCountLabel: UILabel!
    @IBOutlet weak var toppingImageBaseView: UIView!
    @IBOutlet weak var toppingImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
