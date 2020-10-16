//
//  SelectTitleInfoViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class SelectTitleInfoViewController: UIViewController {
    
    private var selectedItems:[Topping] = []
    var selectItemHandler:(([Topping])->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }

    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func showTutorial(_ sender: Any) {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showToppingItem(_ sender: Any) {
        let vc = ToppingSelectViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectItemHandler = {
            self.selectedItems = $0
        }
        self.present(vc, animated: false, completion: nil)
    }
}
