//
//  DescriptionViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/13.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var firstPage: DescriptionView!
    @IBOutlet weak var secondPage: DescriptionView!
    @IBOutlet weak var therdPage: DescriptionView!
    
    // - MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let horizonSizeClass = UITraitCollection(horizontalSizeClass: .regular)
        let verticalSizeClass = UITraitCollection(verticalSizeClass: .regular)
        
        commonInit(isRegularRegularSize: traitCollection.containsTraits(in: horizonSizeClass)
                    && traitCollection.containsTraits(in: verticalSizeClass))
        
    }
 
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func commonInit(isRegularRegularSize: Bool){
        self.view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        pageControl.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        scrollView.delegate = self
        pageControl.isEnabled = false
        
        if isRegularRegularSize {
            firstPage.setDescription(image: UIImage(named: "okura"),
                                     text: localizeString(key: LocalizeKeys.Description.one))
            secondPage.setDescription(image: UIImage(named: "okura"),
                                      text: localizeString(key: LocalizeKeys.Description.two))
            therdPage.setDescription(image: UIImage(named: "okura"),
                                     text: localizeString(key: LocalizeKeys.Description.three))
        } else {
            firstPage.setDescription(image: UIImage(named: "description1"),
                                     text: localizeString(key: LocalizeKeys.Description.one))
            secondPage.setDescription(image: UIImage(named: "description2"),
                                      text: localizeString(key: LocalizeKeys.Description.two))
            therdPage.setDescription(image: UIImage(named: "description3"),
                                     text: localizeString(key: LocalizeKeys.Description.three))
        }
    }
    
}

extension DescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
