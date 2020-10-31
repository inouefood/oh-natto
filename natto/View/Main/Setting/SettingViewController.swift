//
//  SettingViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/26.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SafariServices

class SettingViewController: UIViewController {
    
    let settingArr = [["端末の振動"],
                      [ "プライバシーポリシー", "レビュー", "プッシュ通知", "バージョン"]]
    let sectionArr = ["設定", "その他"]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellType: SettingTableViewCell.self)
            tableView.register(cellType: AppVersionTableViewCell.self)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        tableView.tableFooterView = UIView()
    }
    
    @objc func closeAction() {
        dismiss(animated: true, completion: nil)
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArr[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArr[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: SettingTableViewCell.self, for: indexPath)
            cell.label.text = settingArr[indexPath.section][indexPath.row]
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.row == 0 && indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = settingArr[indexPath.section][indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
            
        } else if indexPath.row == 1 && indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = settingArr[indexPath.section][indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
            
        } else if indexPath.row == 2 && indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = settingArr[indexPath.section][indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(with: AppVersionTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 1 {
            let safariViewController = SFSafariViewController(url: URL(string: "https://inouefood.github.io/inouefood/privacypolicy.html")!)
            present(safariViewController, animated: true, completion: nil)
            
        } else if indexPath.row == 1 && indexPath.section == 1 {
            //実機じゃないと遷移できないので注意
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id1457049172?action=write-review") {
               UIApplication.shared.open(url, options: [:])
            } 
        } else if indexPath.row == 2 && indexPath.section == 1 {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}
