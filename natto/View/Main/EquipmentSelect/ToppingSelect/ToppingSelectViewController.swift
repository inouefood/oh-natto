//
//  ToppingSelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ToppingSelectViewController: UIViewController {
    @IBOutlet weak var firstToppingImage: UIImageView! {
        didSet {
            firstToppingImage.layer.cornerRadius = firstToppingImage.frame.width/2
        }
    }
    @IBOutlet weak var secondToppingImage: UIImageView!{
        didSet {
            secondToppingImage.layer.cornerRadius = secondToppingImage.frame.width/2
        }
    }
    @IBOutlet weak var thirdToppingImage: UIImageView!{
        didSet {
            thirdToppingImage.layer.cornerRadius = thirdToppingImage.frame.width/2
        }
    }
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.layer.cornerRadius = 6
            resetButton.setTitle("リセット", for: .normal)
        }
    }
    var selectHandler: (([Topping])->Void)?
    private var selectTopping:[Topping] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = .orange
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //TODO ここで選択されたものを表示するようにする
        if firstToppingImage.image == nil {
            selectTopping.append(Negi())
            firstToppingImage.image = UIImage(named: "negi")
        } else if secondToppingImage.image == nil {
            selectTopping.append(Negi())
            secondToppingImage.image = UIImage(named: "negi")
        } else {
            selectTopping.append(Negi())
            thirdToppingImage.image = UIImage(named: "negi")
        }
        selectHandler?(selectTopping)

    }
    
    @IBAction func resetAction(_ sender: Any) {
        firstToppingImage.image = nil
        secondToppingImage.image = nil
        thirdToppingImage.image = nil
        
        selectTopping = []
        selectHandler?(selectTopping)
    }
}
