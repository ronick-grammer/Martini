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
    let spacingRow = 10
    let spacingColumn = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BasePreferenceCollectionView.delegate = self
        BasePreferenceCollectionView.dataSource = self
        BasePreferenceCollectionView.register(BasePreferenceCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        btnNext.layer.cornerRadius = 6
        btnNext.titleLabel?.text = "다음"
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
    }

//    override func viewWillAppear(_ animated: Bool) {
//        BasePreferenceCollectionView.reloadData()
//    }
}

extension BasePreferenceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(spacingRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(spacingColumn)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 화면에 최대 4행 3열의 셀만 보이기
        let width = BasePreferenceCollectionView.bounds.width / 3 - CGFloat(spacingColumn)
        let height = BasePreferenceCollectionView.bounds.height / 4 - CGFloat(spacingRow)
        
        return CGSize(width: width, height: height)
    }
}

extension BasePreferenceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alcolBase.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = BasePreferenceCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasePreferenceCollectionViewCell

        cell.configure(fileName: alcolBase[indexPath.row].fileName, alcolName:  alcolBase[indexPath.row].alcolName)
        return cell
    }
}

struct AlcolBase {
    let fileName: String
    let alcolName: String
}

let alcolBase: [AlcolBase] = [
    AlcolBase(fileName: "rum", alcolName: "럼"),
    AlcolBase(fileName: "gin", alcolName: "진"),
    AlcolBase(fileName: "whisky", alcolName: "위스키"),
    AlcolBase(fileName: "tequila", alcolName: "데킬라"),
    AlcolBase(fileName: "brandy", alcolName: "브랜디"),
    AlcolBase(fileName: "vodka", alcolName: "보드카"),
    AlcolBase(fileName: "beer", alcolName: "맥주"),
    AlcolBase(fileName: "soju", alcolName: "소주"),
    AlcolBase(fileName: "champagne", alcolName: "샴페일"),
    AlcolBase(fileName: "wine", alcolName: "와인")
]
