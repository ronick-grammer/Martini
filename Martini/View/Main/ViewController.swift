//
//  ViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/16.
//

import UIKit
import CoreLocation

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.tintColor = .systemRed
        let viewControllers:[UIViewController] = [
            initTabViewController("CocktailMain", identfire: "CocktailMain", title: "칵테일추천", icon: UIImage(systemName: "hand.thumbsup"), tag: 1),
            initTabViewController("Search", identfire: "SearchVC", title: "칵테일찾기", icon: UIImage(systemName: "magnifyingglass"), tag: 2),
            initTabViewController("FindView", identfire: "FindVC", title: "조건검색", icon: UIImage(systemName: "plus.magnifyingglass"), tag: 3),
            initTabViewController("UploadRecipe", identfire: "UploadRecipeVC", title: "칵테일등록", icon: UIImage(systemName: "plus.circle"), tag: 4),
            initTabViewController("SettingView", identfire: "SettingView", title: "설정", icon: UIImage(systemName: "person"), tag: 5)
        ]
        
        self.setViewControllers(viewControllers, animated: false)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AuthManager.shared.userSession == nil {
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
}



extension UITabBarController {
    
    func initTabViewController(_ bundleName: String, identfire: String, title: String, icon: UIImage?, tag: Int) -> UIViewController{
        let vc = UIStoryboard(name: bundleName, bundle: nil).instantiateViewController(withIdentifier: identfire)
        vc.tabBarItem = UITabBarItem(title: title, image: icon, tag: tag)
        return vc
    }
    
}

extension UIViewController {
    
    func alert(_ message: String){
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func initViewController(_ bundleName: String, identfire: String) -> UIViewController{
        let vc = UIStoryboard(name: bundleName, bundle: nil).instantiateViewController(identifier: identfire)
        return vc
    }
    
}
