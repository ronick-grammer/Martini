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
        
//        guard let currentUser = AuthManager.shared.currentUser else { return }
//        DATASTORE.initializeUserPreference(user: currentUser)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}

extension BasePreferenceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cocktail.Alcohol.allCases.count - 1 // 마지막은 type은 없으므로
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = BasePreferenceCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasePreferenceCollectionViewCell
        
        // 각 알콜 베이스의 이미지 이름과 타이틀 이름으로 셀 만들기
        let base = Cocktail.Alcohol.allCases[indexPath.row]
        let baseInfo = getAlcoholInfo(base: base)
        
        let imageName = baseInfo.imageName
        let title = baseInfo.title
        
        cell.configure(imageName: imageName, title: title, index: base.index)
        
        return cell
    }
    
    // 타입에 따른 정보 반환
    func getAlcoholInfo(base: Cocktail.Alcohol) -> AlcoholInfo {
        switch base {
        case .rum       : return AlcoholInfo(imageName: "rum", title: "럼")
        case .gin       : return AlcoholInfo(imageName: "gin", title: "진")
        case .whisky    : return AlcoholInfo(imageName: "whisky", title: "위스키")
        case .tequila   : return AlcoholInfo(imageName: "tequila", title: "데킬라")
        case .brandy    : return AlcoholInfo(imageName: "brandy", title: "브랜디")
        case .vodka     : return AlcoholInfo(imageName: "vodka", title: "보드카")
        case .beer      : return AlcoholInfo(imageName: "beer", title: "맥주")
        case .soju      : return AlcoholInfo(imageName: "soju", title: "소주")
        case .champagne : return AlcoholInfo(imageName: "champagne", title: "샴페인")
        case .wine      : return AlcoholInfo(imageName: "wine", title: "와인")
        default         : return AlcoholInfo(imageName: "", title: "")
        }
    }
}


struct AlcoholInfo {
    let imageName: String
    let title: String
}


