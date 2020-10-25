//
//  EquipmentSelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/20.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import Parchment

class EquipmentSelectViewController: UIViewController {
    @IBOutlet weak var closeButton: CloseButton!
    
    private lazy var pagingItem: [UIViewController] = {
        let toppingVC = ToppingSelectViewController()
        toppingVC.selectHandler = {
            self.selectedItems = $0
        }
        toppingVC.decisionAction = {
            self.selectItemHandler?(self.selectedItems)
            self.dismiss(animated: true, completion: nil)
        }
        toppingVC.title = "トッピング"
        
        let secondVC = ItemSelectViewController()
        secondVC.title = "アイテム"
        let thirdVC = MameSelectViewController()
        thirdVC.title = "豆"
        
        return [toppingVC, secondVC, thirdVC]
    }()
    
    var selectedItems: [Topping] = []
    
    var selectItemHandler:(([Topping])->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pagingViewController = PagingViewController(viewControllers: pagingItem)

        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        pagingViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pagingViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pagingViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pagingViewController.view.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 0).isActive = true

    }
    
    @IBAction func dismissAction(_ sender: Any) {
        selectItemHandler?(selectedItems)
        dismiss(animated: true, completion: nil)

    }
    
}
