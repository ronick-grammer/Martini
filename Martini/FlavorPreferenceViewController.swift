//
//  FlavorPreferenceViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/25.
//

import UIKit

class FlavorPreferenceViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var flavorPreferenceCollectionView: UICollectionView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnPrev: UIButton!
    @IBOutlet var btnComplete: UIButton!
    
    let identifier = "flavorPreferenceCollectionViewCell"
    let spacingRow = 15
    
    var registrationType: RegistrationType = .user

    override func viewDidLoad() {
        super.viewDidLoad()

        flavorPreferenceCollectionView.dataSource = self
        flavorPreferenceCollectionView.delegate = self
        flavorPreferenceCollectionView.register(FlavorPreferenceCollectionViewCell.self, forCellWithReuseIdentifier: identifier)

        
        if registrationType == .user {
            btnNext.layer.cornerRadius = 6
            btnNext.titleLabel?.text = "다음"
            btnNext.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            
            btnPrev.layer.cornerRadius = 6
            btnPrev.titleLabel?.text = "이전"
            btnPrev.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            
            btnComplete.isHidden = true
            
            titleLabel.text = "어떤 맛을 선호하시나요?"
        } else {
            btnComplete.layer.cornerRadius = 6
            btnComplete.titleLabel?.text = "완료"
            btnComplete.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            
            btnPrev.isHidden = true
            btnNext.isHidden = true
            
            titleLabel.text = "칵테일의 맛을 설정해주세요!"
        }
    }
    
    @IBAction func btnPrevView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextView(_ sender: UIButton) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "IngredientsSelectionView", bundle: Bundle.main)
        
        guard let uvc = storyboard?.instantiateViewController(identifier: "ingredientsSelection") else { return }
        
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
        return Cocktail.Taste.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flavorPreferenceCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FlavorPreferenceCollectionViewCell
        
        // 각 맛의 서브 타이틀로 셀 만들기
        let taste = Cocktail.Taste.allCases[indexPath.row]
        let tasteInfo = getTasteInfo(taste: taste)
        let subtitle = tasteInfo.subtitle
        
        cell.configure(subtitle: subtitle, index: taste.index, registrationType: self.registrationType)
        
        return cell
    }
    
    // 타입에 따른 정보 반환
    func getTasteInfo(taste: Cocktail.Taste) -> TasteInfo {
        switch taste {
        case .sweety: return TasteInfo(title: "단맛", subtitle: "단맛이 강한 음료가 좋습니다")
        case .spicy : return TasteInfo(title: "매운맛", subtitle: "매운 맛을 좋아해요")
        case .salty : return TasteInfo(title: "짠맛", subtitle: "짭조름한 맛이 났으면 좋겠어요!")
        case .creamy: return TasteInfo(title: "부드러운맛", subtitle: "부드러운 맛이 있었으면 좋겠어요!")
        case .bitter: return TasteInfo(title: "술맛", subtitle: "술맛이 강했으면 좋겠어요")
        }
    }
}

struct TasteInfo {
    let title: String
    let subtitle: String
}
