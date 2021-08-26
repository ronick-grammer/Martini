//
//  SettingViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/26.
//

import UIKit

class SettingViewController: UIViewController {
    
    let settingMenu = [
        "내 회원정보 수정",
        "앱 세팅",
        "내가 찜한 목록"
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.navigationItem.title = settingMenu[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        
        cell.textLabel?.text = settingMenu[indexPath.row]
        
        return cell
        
    }
    
    
}
