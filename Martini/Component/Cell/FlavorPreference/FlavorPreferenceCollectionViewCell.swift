//
//  FlavorPreferenceCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/08/25.
//

import UIKit

class FlavorPreferenceCollectionViewCell: UICollectionViewCell, SliderStrenthDelegate {
    
    var sliderStrenth = SliderStrenth()
    var index = Int()
    
    var registrationType: RegistrationType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func setupLayout() {
        // 슬라이더 모양 가장자리 둥글게
        // frame.size가 설정되고 나서 호출해야 오류가 발생하지 않음
        sliderStrenth.setMinMaxTrackImage(size: self.frame.size)
        
        self.addSubview(sliderStrenth)
        
        sliderStrenth.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderStrenth.topAnchor.constraint(equalTo: self.topAnchor),
            sliderStrenth.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sliderStrenth.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sliderStrenth.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        sliderStrenth.delegate = self // 슬라이더 값이 변경될 때, 데이터를 가져와야 함
    }
    
    // 슬라이더 상태 (유지)초기화
    func configure(subtitle: String, index: Int, registrationType: RegistrationType) {
        
        self.registrationType = registrationType
        self.index = index
        
        let tasteStrenth = initState()
        
        sliderStrenth.labelTitle.text = subtitle
        sliderStrenth.labelPercentage.text = "\(tasteStrenth)%"
        sliderStrenth.slider.setValue(Float(tasteStrenth) / 100, animated: false)
    }
    
    // 타입별로 슬라이더 상태 초기화
    func initState() -> Int{
        
        switch self.registrationType {
        case .user:
            return DATASTORE.user?.tastePreference?[Cocktail.Taste.allCases[self.index].rawValue] ?? 0
        case .cocktail:
            return DATASTORE_COCKTAIL?.taste[Cocktail.Taste.allCases[self.index]] ?? 0
        default:
            return 0
        }
    }
    
    func didChangeValue(value: Double) {
        
        switch self.registrationType {
        case .user:
            storeUserData(value: value)
        case .cocktail:
            storeCocktailData(value: value)
        case .none:
            break
        }
    }
    
    // 유저 등록 데이터스토어
    func storeUserData(value: Double) {
        let tasteType = Cocktail.Taste.allCases[self.index].rawValue
        DATASTORE.user?.tastePreference?.updateValue(Int(value), forKey: tasteType)
    }
    
    // 칵테일 등록 데이터스토어
    func storeCocktailData(value: Double) {
        let tasteType = Cocktail.Taste.allCases[self.index]
        DATASTORE_COCKTAIL?.taste.updateValue(Int(value), forKey: tasteType)
    }
}
