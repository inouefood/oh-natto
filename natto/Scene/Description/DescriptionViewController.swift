//
//  DescriptionViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/13.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var descriptionLabel1: UILabel! {
        didSet {
            descriptionLabel1.text = localizeString(key: LocalizeKeys.Description.one) 
        }
    }
    @IBOutlet weak var descriptionLabel2: UILabel! {
        didSet {
            descriptionLabel2.text = localizeString(key: LocalizeKeys.Description.two)
        }
    }
    @IBOutlet weak var descriptionLabel3: UILabel! {
        didSet {
            descriptionLabel3.text = localizeString(key:LocalizeKeys.Description.three)
        }
    }
    
    // - MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    
    // - MARK: Event
    
    @IBAction func closeDescription(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
