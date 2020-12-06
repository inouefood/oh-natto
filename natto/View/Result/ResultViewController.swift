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
import GameKit

class ResultViewController: UIViewController {
    var audio: AVAudioPlayer!
    private var score: Int
    private let tipsList: [String] = [localizeString(key: LocalizeKeys.Tips.a),
                                      localizeString(key: LocalizeKeys.Tips.b),
                                      localizeString(key: LocalizeKeys.Tips.c),
                                      localizeString(key: LocalizeKeys.Tips.d),
                                      localizeString(key: LocalizeKeys.Tips.e),
                                      localizeString(key: LocalizeKeys.Tips.f),
                                      localizeString(key: LocalizeKeys.Tips.g),
                                      localizeString(key: LocalizeKeys.Tips.h),
                                      localizeString(key: LocalizeKeys.Tips.i),
                                      localizeString(key: LocalizeKeys.Tips.j),
                                      localizeString(key: LocalizeKeys.Tips.k),
                                      localizeString(key: LocalizeKeys.Tips.l),
                                      localizeString(key: LocalizeKeys.Tips.m),
                                      localizeString(key: LocalizeKeys.Tips.n),
                                      localizeString(key: LocalizeKeys.Tips.o),
                                      localizeString(key: LocalizeKeys.Tips.p)]

    var dismissHandler: (()->())?
    
    @IBOutlet weak var tipsTitleLabel: UILabel! {
        didSet {
            tipsTitleLabel.text = localizeString(key: LocalizeKeys.Result.tipsTitle)
        }
    }
    @IBOutlet weak var screenShotView: UIView!
    @IBOutlet weak var tipsLabel: UILabel! {
        didSet {
            tipsLabel.text = tipsList.randomElement()
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
        sendLeaderboardWithID(ID: Constant.LeaderBoard.id, rate: Int64(score))
        //レビューダイアログの表示
        if UserStore.totalNattoCount > 1000 && UserStore.isNeedDisplayedReviewAlert {
            UserStore.isNeedDisplayedReviewAlert = false
            SKStoreReviewController.requestReview()
        }
        
        guard let bestScore = UserStore.bestScore else {
            UserStore.bestScore = score
            return
        }
        print("bestScoreは：\(bestScore)")
        
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
    
    func sendLeaderboardWithID(ID:String, rate:Int64) -> Void {
        let score = GKScore(leaderboardIdentifier: ID)
        if GKLocalPlayer.local.isAuthenticated {
            //スコアを設定
            score.value = rate
            print("success")
            GKScore.report([score], withCompletionHandler: { (error) in
                if error != nil {
                    // エラーの場合
                    print("error: \(String(describing: error))")
                }
            })
        } else {
            print("GameCenterにログインしていません")
        }
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
