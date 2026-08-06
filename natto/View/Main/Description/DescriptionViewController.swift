//
//  DescriptionViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/13.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - SwiftUI Views

private struct DescriptionPageView: View {
    let imageName: String
    let text: String
    let backgroundColor: Color

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                backgroundColor
                    .frame(height: geo.size.height * 0.5)
                    .overlay(
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(32)
                    )
                    .clipped()

                Color("background")
                    .overlay(
                        Text(text)
                            .font(.scaled(35, weight: .semibold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(13.0 / 35.0)
                            .padding(.horizontal, 16)
                            .padding(.top, 16),
                        alignment: .topLeading
                    )
            }
        }
        .ignoresSafeArea()
    }
}

private struct DescriptionContentView: View {
    let isRegularRegular: Bool
    @State private var currentPage = 0
    let onDismiss: () -> Void

    private var pages: [(image: String, text: String)] {
        let suffix = isRegularRegular ? "ipad" : ""
        return [
            ("nattoTutorial-1", localizeString(key: LocalizeKeys.Description.one)),
            ("nattoTutorial-2\(suffix)", localizeString(key: LocalizeKeys.Description.two)),
            ("nattoTutorial-3\(suffix)", localizeString(key: LocalizeKeys.Description.three)),
            ("nattoTutorial-4\(suffix)", localizeString(key: LocalizeKeys.Description.four)),
            ("nattoTutorial-5", localizeString(key: LocalizeKeys.Description.five)),
            ("nattoTutorial-6", localizeString(key: LocalizeKeys.Description.six)),
        ]
    }

    private let pageColors: [Color] = [
        .yellow,
        .green,
        .orange,
        Color(red: 0.353, green: 0.784, blue: 0.98),
        .pink,
        Color(.systemGray),
    ]

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { idx, page in
                    DescriptionPageView(
                        imageName: page.image,
                        text: page.text,
                        backgroundColor: pageColors[idx]
                    )
                    .tag(idx)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            // Page indicator at bottom
            VStack {
                Spacer()
                HStack(spacing: 6) {
                    ForEach(0..<pages.count, id: \.self) { idx in
                        Circle()
                            .fill(idx == currentPage
                                ? Color(red: 0.9, green: 0, blue: 0.07)
                                : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                            .animation(.easeInOut(duration: 0.2), value: currentPage)
                    }
                }
                .scaleEffect(2.0)
                .padding(.bottom, 40)
            }

            // Close button
            HStack {
                Spacer()
                Button(action: onDismiss) {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .buttonStyle(.plain)
                .padding(.top, 16)
                .padding(.trailing, 16)
            }
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - UIViewController

#Preview("ページ単体") {
    DescriptionPageView(
        imageName: "nattoTutorial-1",
        text: "納豆をいっぱい食べよう！",
        backgroundColor: .yellow
    )
}

#Preview("チュートリアル全体") {
    DescriptionContentView(isRegularRegular: false, onDismiss: {})
}

class DescriptionViewController: UIViewController {
    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let isRegularRegular = traitCollection.horizontalSizeClass == .regular
            && traitCollection.verticalSizeClass == .regular
        let swiftUIView = DescriptionContentView(
            isRegularRegular: isRegularRegular,
            onDismiss: { [weak self] in self?.dismiss(animated: true) }
        )
        let hc = UIHostingController(rootView: swiftUIView)
        hc.view.backgroundColor = .clear
        addChild(hc)
        view.addSubview(hc.view)
        hc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hc.view.topAnchor.constraint(equalTo: view.topAnchor),
            hc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        hc.didMove(toParent: self)
    }
}
