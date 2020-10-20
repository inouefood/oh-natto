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
        let firstVC = SelectTitleInfoViewController()
        firstVC.title = "first"
        let secondVC = SelectTitleInfoViewController()
        secondVC.title = "second"
        let thirdVC = SelectTitleInfoViewController()
        thirdVC.title = "third"
        
        return [firstVC, secondVC, thirdVC]
    }()
    
    private var selectedItems: [Topping] = []
    
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
        pagingViewController.view.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16).isActive = true

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
