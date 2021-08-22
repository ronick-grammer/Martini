//
//  ViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ViewController: UIViewController {
    
    @IBOutlet var sliderStrenth: SliderStrenth!

    @IBOutlet var buttonFirst: BannerToggleButton!
    
    @IBOutlet var buttonSecond: BannerToggleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonFirst.buttonImage.image = UIImage(named: "wine")
        buttonSecond.buttonImage.image = UIImage(systemName: "star.fill")
    }
}
