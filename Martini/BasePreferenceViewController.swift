//
//  BasePreferenceViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/22.
//

import UIKit

class BasePreferenceViewController: UIViewController {

    @IBOutlet var BasePreferenceCollectionView: UICollectionView!
    
    @IBOutlet var btnNext: UIButton!
    let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacingRow = 10
        let spacingColumn = 20
        let width = BasePreferenceCollectionView.bounds.width / 3 - CGFloat(spacingColumn)
        let height = BasePreferenceCollectionView.bounds.height / 4 - CGFloat(spacingRow)
        
        layout.minimumLineSpacing = CGFloat(spacingRow)
        layout.minimumInteritemSpacing = CGFloat(spacingColumn)
        layout.itemSize = CGSize(width: width, height: height)
        BasePreferenceCollectionView.collectionViewLayout = layout
        
//        BasePreferenceCollectionView.delegate = self
        BasePreferenceCollectionView.dataSource = self
        BasePreferenceCollectionView.register(BasePreferenceCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        btnNext.layer.cornerRadius = 6
//        btnNext.frame.size = CGSize(width: 70, height: 20)
        btnNext.titleLabel?.font = UIFont.init(name: "다음", size: 15)
        
    }

//    override func viewWillAppear(_ animated: Bool) {
//        BasePreferenceCollectionView.reloadData()
//    }
    
}
//
//extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("tapped collectionViewCell")
//    }
//}

extension BasePreferenceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = BasePreferenceCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasePreferenceCollectionViewCell

        cell.configure(fileName: alcolBase[indexPath.row].fileName, alcolName:  alcolBase[indexPath.row].fileName)
        return cell
    }
}


struct AlcolBase {
    let fileName: String
}

let alcolBase: [AlcolBase] = [
    AlcolBase(fileName: "rum"),
    AlcolBase(fileName: "gin"),
    AlcolBase(fileName: "whisky"),
    AlcolBase(fileName: "tequila"),
    AlcolBase(fileName: "brandy"),
    AlcolBase(fileName: "vodka"),
    AlcolBase(fileName: "beer"),
    AlcolBase(fileName: "soju"),
    AlcolBase(fileName: "champagne"),
    AlcolBase(fileName: "wine"),
]
