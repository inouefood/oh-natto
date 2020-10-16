//
//  ToppingSelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import Parchment

class ToppingSelectViewController: UIViewController {
    
    private var selectedItems: [Topping] = []
    
    var selectItemHandler:(([Topping])->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectedItems.append(Negi())
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        selectItemHandler?(selectedItems)
        dismiss(animated: false, completion: nil)
    }
    

}
