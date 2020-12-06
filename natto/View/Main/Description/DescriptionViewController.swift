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
    
    @IBOutlet weak var zeroPage: DescriptionView!
    @IBOutlet weak var firstPage: DescriptionView!
    @IBOutlet weak var secondPage: DescriptionView!
    @IBOutlet weak var therdPage: DescriptionView!
    @IBOutlet weak var fourthPage: DescriptionView!
    @IBOutlet weak var fifthPage: DescriptionView!
    
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
        self.view.backgroundColor = AppColor.background.color
        pageControl.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        scrollView.delegate = self
        pageControl.isEnabled = false
        zeroPage.setDescription(image: UIImage(named: "nattoTutorial-1"),
                                text: localizeString(key: LocalizeKeys.Description.one))
        if isRegularRegularSize {
            
            firstPage.setDescription(image: UIImage(named: "nattoTutorial-2ipad"),
                                     text: localizeString(key: LocalizeKeys.Description.two))
            secondPage.setDescription(image: UIImage(named: "nattoTutorial-3ipad"),
                                      text: localizeString(key: LocalizeKeys.Description.three))
            therdPage.setDescription(image: UIImage(named: "nattoTutorial-4ipad"),
                                     text: localizeString(key: LocalizeKeys.Description.four))
            
        } else {
            firstPage.setDescription(image: UIImage(named: "nattoTutorial-2"),
                                     text: localizeString(key: LocalizeKeys.Description.two))
            secondPage.setDescription(image: UIImage(named: "nattoTutorial-3"),
                                      text: localizeString(key: LocalizeKeys.Description.three))
            therdPage.setDescription(image: UIImage(named: "nattoTutorial-4"),
                                     text: localizeString(key: LocalizeKeys.Description.four))
            
        }
        fourthPage.setDescription(image: UIImage(named: "nattoTutorial-5"),
                                  text: localizeString(key: LocalizeKeys.Description.five))
        fifthPage.setDescription(image: UIImage(named: "nattoTutorial-6"),
                                 text: localizeString(key: LocalizeKeys.Description.six))
    }
    
}

extension DescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
