//
//  SettingViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/26.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    let settingArr = ["端末の振動", "プライバシーポリシー", "レビュー", "プッシュ通知"]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellType: SettingTableViewCell.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "設定"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close")?.withRenderingMode(.alwaysOriginal),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(closeAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func closeAction() {
        dismiss(animated: true, completion: nil)
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SettingTableViewCell.self, for: indexPath)
        cell.label.text = settingArr[indexPath.row]
        return cell
    }
    
}
