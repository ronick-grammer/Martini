//
//  AppSettingViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/09/08.
//

import UIKit

class AppSettingViewController: UIViewController {
    
    static let bundleName = "SettingView"
    static let identfireName = "appSetting"
    
    let items = [
        "푸쉬알림 설정",
        "위치권한 설정",
        "로그아웃"
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
}

extension AppSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0, 1:
            guard let url = URL(string: UIApplication.openSettingsURLString) else { break }
            
//            guard let url = URL(string: "prefs:root=com.martiniapp.Martini") else { break }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 2:
            if(AuthManager.shared.userSession != nil){
                AuthManager.shared.logout { result, error in
                    guard result else { return }
                    self.navigationController?.popViewController(animated: true)
                    self.tabBarController?.selectedIndex = 0
                    
                    let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
                    vc.modalPresentationStyle = .fullScreen
                    self.tabBarController?.present(vc, animated: true, completion: nil)
                }
            } else {
                self.navigationController?.popViewController(animated: true)
                self.tabBarController?.selectedIndex = 0
                
                let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
                vc.modalPresentationStyle = .fullScreen
                self.tabBarController?.present(vc, animated: true, completion: nil)
            }
            
        default:
            break
            
        }
    }
    
}

extension AppSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}
