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
    
    let reuseIdentifier = "basePreferenceCollectionViewCell"
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
    

    @IBAction func btnNextView(_ sender: UIButton) {
        
        // 스토리 보드 객체 가져오기 (인자 : 이름, 읽어들일 위치)
        let storyboard: UIStoryboard? = UIStoryboard(name: "FlavorPreferenceView", bundle: Bundle.main)
        
        // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
        guard let uvc = storyboard?.instantiateViewController(identifier: "flavorPreference") else {
            return
        }

        self.navigationController?.pushViewController(uvc, animated: true)
        
    }
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
        return Cocktail.Alcol.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = BasePreferenceCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasePreferenceCollectionViewCell
        
        if let type = Cocktail.Alcol.init(rawValue: indexPath.row)?.type {
            let fileName = type.fileName
            let title = type.title
            
            cell.configure(fileName: fileName, alcolName: title)
        }

        return cell
    }
}
