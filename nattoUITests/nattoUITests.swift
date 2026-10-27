//
//  nattoUITests.swift
//  nattoUITests
//
//  Created by 佐川晴海 on 2019/04/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import XCTest

class nattoUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    // ストア用スクリーンショット撮影のために1プレイ分を自動操作する
    // 撮影自体は外部から simctl io screenshot で行う
    func testPlayOneGameForScreenshots() {
        let app = XCUIApplication()
        // 初回のチュートリアルを出さない
        app.launchArguments += ["-isFirstSession", "<false/>"]
        app.launch()

        // 通知の許可ダイアログが出たら許可する
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let alert = springboard.alerts.firstMatch
        if alert.waitForExistence(timeout: 5) {
            alert.buttons.element(boundBy: alert.buttons.count - 1).tap()
        }

        // タイトル画面を撮影するための待ち時間
        Thread.sleep(forTimeInterval: 4)

        // 「はじめる」は物理演算で動くので、背景色が変わるまで画面中央付近を順にタップする
        let titleColor = cornerColor(of: app)
        let points: [CGVector] = [0.5, 0.42, 0.58, 0.35, 0.65].flatMap { x in
            [0.45, 0.35, 0.55, 0.65, 0.75, 0.85].map { y in CGVector(dx: x, dy: y) }
        }
        var started = false
        for p in points {
            app.coordinate(withNormalizedOffset: p).tap()
            if cornerColor(of: app) != titleColor {
                started = true
                break
            }
        }
        XCTAssertTrue(started, "はじめるをタップできなかった")

        // 混ぜる画面（10秒）: お箸を左右上下に動かして混ぜる
        let mixPath: [CGVector] = [
            CGVector(dx: 0.3, dy: 0.5), CGVector(dx: 0.7, dy: 0.6),
            CGVector(dx: 0.4, dy: 0.7), CGVector(dx: 0.6, dy: 0.45),
        ]
        for i in 0..<8 {
            let from = app.coordinate(withNormalizedOffset: mixPath[i % mixPath.count])
            let to = app.coordinate(withNormalizedOffset: mixPath[(i + 1) % mixPath.count])
            from.press(forDuration: 0.05, thenDragTo: to, withVelocity: XCUIGestureVelocity(1500), thenHoldForDuration: 0)
        }

        // 食べる画面（25秒）: 下から上の口までお箸で納豆を持ち上げる
        Thread.sleep(forTimeInterval: 2)
        for i in 0..<9 {
            let x = 0.4 + 0.1 * Double(i % 3)
            let from = app.coordinate(withNormalizedOffset: CGVector(dx: x, dy: 0.85))
            let to = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
            from.press(forDuration: 0.3, thenDragTo: to, withVelocity: XCUIGestureVelocity(400), thenHoldForDuration: 0.8)
        }

        // 結果画面を撮影するための待ち時間
        Thread.sleep(forTimeInterval: 15)
    }

    // 画面左上の色（シーン切り替えの判定用。落ちてくる豆と重ならない位置）
    private func cornerColor(of app: XCUIApplication) -> [UInt8] {
        guard let cgImage = app.screenshot().image.cgImage else { return [] }
        var pixel = [UInt8](repeating: 0, count: 4)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        // CGContextは左下原点。画像の上端から200px・左端から40pxの1ピクセルを描画する
        context?.draw(cgImage, in: CGRect(x: -40, y: -(cgImage.height - 200),
                                          width: cgImage.width, height: cgImage.height))
        return pixel
    }
}
