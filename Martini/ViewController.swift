//
//  ViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/16.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchVC")
        
        self.present(vc, animated: true, completion: nil)
    }

}
