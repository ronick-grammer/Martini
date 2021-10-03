//
//  PreferenceCompleteViewController.swift
//  Martini
//
//  Created by RONICK on 2021/09/13.
//

import UIKit

class PreferenceCompleteViewController: UIViewController {

    @IBOutlet var btn: UIButton!
    @IBOutlet var imgComplete: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = COLOR_MARTINI.button_clickable
        
        imgComplete.tintColor = COLOR_MARTINI.button_clickable
    }
    
    @IBAction func btnComplete(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(identifier: "main")
        
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
}
