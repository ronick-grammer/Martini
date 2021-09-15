//
//  PreferenceCompleteViewController.swift
//  Martini
//
//  Created by RONICK on 2021/09/13.
//

import UIKit

class PreferenceCompleteViewController: UIViewController {

    @IBOutlet var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    @IBAction func btnComplete(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(identifier: "main")
        
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
}
