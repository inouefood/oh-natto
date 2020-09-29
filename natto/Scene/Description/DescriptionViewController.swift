//
//  DescriptionViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/13.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var firstPage: DescriptionView! {
        didSet {
            
            firstPage.setDescription(image: UIImage(named: "description1"),
                                     text: localizeString(key: LocalizeKeys.Description.one))
        }
    }
    @IBOutlet weak var secondPage: DescriptionView!{
        didSet {
            secondPage.setDescription(image: UIImage(named: "description2"),
                                      text: localizeString(key: LocalizeKeys.Description.two))
        }
    }
    @IBOutlet weak var therdPage: DescriptionView!{
        didSet {
            therdPage.setDescription(image: UIImage(named: "description3"),
                                     text: localizeString(key: LocalizeKeys.Description.three))
        }
    }
    
    // - MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
 
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
