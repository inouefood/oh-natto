//
//  TLHorizontalScrollView.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/13.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import UIKit

class TLHorizontalScrollView : UIScrollView{
    
    // タップ開始時のスクロール位置格納用
    var startPoint : CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Initialize()
    }
    
    // initialize method
    func Initialize(){
        self.delegate = self
        
        // 横固定なので縦のIndicatorいらない
        self.showsVerticalScrollIndicator = false
    }
}

extension TLHorizontalScrollView : UIScrollViewDelegate{
    
    // ドラッグ開始時のスクロール位置記憶
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.startPoint = scrollView.contentOffset
    }
    
    // ドラッグ(スクロール)しても y 座標は開始時から動かないようにする(固定)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = self.startPoint.x
    }
}
