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
    
    private let tipsStrings: [String] = ["弥生時代にはすでに納豆はあったらしいよ",
                                         "納豆が一般庶民の間で広く食べられるようになったのは江戸時代なんだって",
                                         "納豆という文字が文献に最初に出てきたのは平安時代だよ",
                                         "納豆は大きく２種類「糸引き納豆」と「塩辛納豆」があるよ",
                                         "納豆には煮豆には無い栄養素もはいっているんだよ",
                                         "納豆には1gあたり約10億個の納豆菌が住んでいるんだって",
                                         "納豆1gにいる納豆菌を一列に並べると1000kmの長さになるんだよ",
                                         "納豆菌は生命力がとても強いから煮たばかりの熱々の豆に触れても死なないんだよ",
                                         "ネバネバには水を抱え込む効果があって砂漠を緑にすることも考えられているんだよ",
                                         "納豆の匂いには６８種類の匂い成分があるんだって",
                                         "納豆は４００回混ぜるととってもおいしくなるんだよ",
                                         "納豆と卵の白身は相性が悪くて一緒に食べると美肌効果がなくなってしまうんだ",
                                         "納豆は１月〜３月が旬の食べごろだよ",
                                         "納豆を混ぜる専用の納豆箸みんなもってる？",
                                         "納豆を一番食べてるのは福島県なんだって",
                                         "インドネシアには納豆によく似たテンペって食べ物があるよ"]
    
    var dismissHandler: (()->())?
    
    @IBOutlet weak var tipsTitleLabel: UILabel! {
        didSet {
            tipsTitleLabel.text = localizeString(key: LocalizeKeys.Result.tipsTitle)
        }
    }
    @IBOutlet weak var screenShotView: UIView!
    @IBOutlet weak var tipsLabel: UILabel! {
        didSet {
            tipsLabel.text = tipsStrings[Int(arc4random_uniform(UInt32(tipsStrings.count)))]
        }
    }
    @IBOutlet weak var scoreTitleLabel: UILabel! {
        didSet {
            scoreTitleLabel.text = localizeString(key: LocalizeKeys.Result.scoreTitle)
        }
    }
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.text = String(score) + localizeString(key: LocalizeKeys.Result.score)
        }
    }
    @IBOutlet weak var retryButton: UIButton! {
        didSet {
            retryButton.titleLabel?.font = UIFont(name: "Verdana-bold", size: 35)
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
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColor.background.color
        loadAudio(resourceName: "natto_bgm_score.wav", resourceType: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //レビューダイアログの表示
        if UserStore.totalNattoCount > 1000 && UserStore.isNeedDisplayedReviewAlert {
            UserStore.isNeedDisplayedReviewAlert = false
            SKStoreReviewController.requestReview()
        }
        
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

    @IBAction func openSelectAction(_ sender: Any) {
        let vc = SelectViewController()
        vc.shareImage = screenShotView.convertToImage()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
    }
    
}
