//
//  FlavorPreferenceViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/25.
//

import UIKit

class FlavorPreferenceViewController: UIViewController {
    
    @IBOutlet var flavorPreferenceCollectionView: UICollectionView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnPrev: UIButton!
    
    let identifier = "flavorPreferenceCollectionViewCell"
    let spacingRow = 15

    override func viewDidLoad() {
        super.viewDidLoad()

        flavorPreferenceCollectionView.dataSource = self
        flavorPreferenceCollectionView.delegate = self
        flavorPreferenceCollectionView.register(FlavorPreferenceCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        btnPrev.layer.cornerRadius = 6
        btnPrev.titleLabel?.text = "이전"
        btnPrev.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        btnNext.layer.cornerRadius = 6
        btnNext.titleLabel?.text = "다음"
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
}

extension FlavorPreferenceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spacingRow)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 열은 하나이기 때문에 간격을 주지 않음
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 한 화면에 최대 6개의 셀만 세로로 보이기
        let width = flavorPreferenceCollectionView.bounds.width
        let height = flavorPreferenceCollectionView.bounds.height / 6 - CGFloat(spacingRow)
        
        return CGSize(width: width, height: height)
    }
}

extension FlavorPreferenceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flavorPreferenceTitleText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flavorPreferenceCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FlavorPreferenceCollectionViewCell
        
        cell.configure(title: flavorPreferenceTitleText[indexPath.row])
        
        return cell
    }
}

let flavorPreferenceTitleText: [String] = [
    "단맛이 강한 음료가 좋습니다",
    "부드러운 맛이 있었으면 좋겠어요",
    "술맛이 강했으면 좋겠어요!",
    "새로운 맛을 원해요"
]
