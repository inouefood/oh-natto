//
//  DescriptionView.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/09/29.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class DescriptionView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       loadNib()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        //CustomViewの部分は各自作成したXibの名前に書き換えてください
        let view = Bundle.main.loadNibNamed("DescriptionView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

    
    func setDescription(image: UIImage?, text:String) {
        imageView.image = image
        descriptionLabel.text = text
    }

}
