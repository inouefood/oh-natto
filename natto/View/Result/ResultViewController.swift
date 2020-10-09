//
//  ResultViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/04.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import StoreKit
import AVFoundation

class ResultViewController: UIViewController {
    var audio: AVAudioPlayer!
    private var score: Int
    
    var dismissHandler: (()->())?
    
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.text = localizeString(key: LocalizeKeys.Result.score) + String(score)
            scoreLabel.font = UIFont(name: "Verdana-bold", size: 35)
        }
    }
    @IBOutlet weak var bestScoreLabel: UILabel! {
        didSet {
            guard let bsetScore = UserStore.bestScore else {
                bestScoreLabel.isHidden = true
                return
            }
            bestScoreLabel.text = localizeString(key: LocalizeKeys.Result.bestScore) + bsetScore.description
            bestScoreLabel.font = UIFont(name: "Verdana-bold", size: 25)
        }
    }
    @IBOutlet weak var totalNattoDescriptionLabel: UILabel! {
        didSet {
            totalNattoDescriptionLabel.font = UIFont(name: "Verdana-bold", size: 25)
        }
    }
    @IBOutlet weak var totalNattoCountLabel: UILabel! {
        didSet {
            totalNattoCountLabel.font = UIFont(name: "Verdana-bold", size: 25)
        }
    }
    @IBOutlet weak var retryButton: UIButton! {
        didSet {
            retryButton.titleLabel?.font = UIFont(name: "Verdana-bold", size: 35)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            let imageArr:[UIImage]? = [UIImage(named: "mame01")!,
                                       UIImage(named: "mame02")!,
                                       UIImage(named: "mame03")!,
                                       UIImage(named: "mame02")!]

            imageView.animationImages = imageArr
            imageView.animationDuration = 0.9
            imageView.animationRepeatCount = 0
                    
            imageView.startAnimating()
        }
    }
    // MARK: - Initializer
    init(score: Int) {
        self.score = score
        //値の保存
        UserStore.saveEatPoint(natto: score)
        UserStore.totalNattoCount += score
        
        super.init(nibName: String(describing: ResultViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        loadAudio(resourceName: "natto_bgm_score.wav", resourceType: "")
        
        //レビューダイアログの表示
        if UserStore.totalNattoCount > 1000 && UserStore.isNeedDisplayedReviewAlert {
            UserStore.isNeedDisplayedReviewAlert = false
            SKStoreReviewController.requestReview()
        }
        
        let totalNattoCount = UserStore.totalNattoCount
        totalNattoCountLabel.text = totalNattoCount.description + "粒"
        
        //紙吹雪表示処理の判定
        guard let bestScore = UserStore.bestScore else {
            UserStore.bestScore = score
            return
        }
        
        if score > bestScore {
            let vc = BestScoreViewController(score: score)
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: false, completion: nil)
        }
    }
    
    // MARK: - PrivateMethod
    private func loadAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  audio = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        audio.numberOfLoops = -1
        audio.prepareToPlay()
        audio.play()
    }
    @IBAction func retryAction(_ sender: Any) {
        dismissHandler?()
    }

}
