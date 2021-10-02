//
//  BasePreferenceCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/08/22.
//

import UIKit



class BasePreferenceCollectionViewCell: UICollectionViewCell, BannerToggleButtonDelegate {
    
    let bannerToggleButton = BannerToggleButton()
    var index = Int()
    
    var registrationType: RegistrationType?
    
    static var lastButton: BannerToggleButton? // 가장 마지막에 누른 버튼
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLayout()
    }
    
    func setUpLayout() {
        self.addSubview(bannerToggleButton)

        bannerToggleButton.translatesAutoresizingMaskIntoConstraints = false
        bannerToggleButton.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            bannerToggleButton.topAnchor.constraint(equalTo: self.topAnchor),
            bannerToggleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bannerToggleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bannerToggleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        bannerToggleButton.delegate = self // 버튼 클릭했을때 데이터를 넘겨받아야 함
    }
    
    // 버튼 상태 (유지)초기화
    func configure(imageName: String, title: String, index: Int, registrationType: RegistrationType) {
        
        bannerToggleButton.bannerImage.image = UIImage(named: imageName)
        bannerToggleButton.buttonTitleLabel.text = title
        
        self.index = index
        self.registrationType = registrationType
        
        guard let clicked = initState() else { return }
        
        if clicked {
            bannerToggleButton.banner.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)
            bannerToggleButton.buttonTitleLabel.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)
            
            BasePreferenceCollectionViewCell.lastButton = bannerToggleButton
        } else {
            bannerToggleButton.banner.backgroundColor = #colorLiteral(red: 0.8110396266, green: 0.8110588193, blue: 0.8110484481, alpha: 1)
            bannerToggleButton.buttonTitleLabel.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        }
        
        bannerToggleButton.isClicked = clicked
    }
    
    // 등록 타입별로 상태 초기화
    func initState() -> Bool? {
        
        let clicked: Bool?
        
        switch self.registrationType {
        case .user:
            clicked = DATASTORE.user?.basePreference?.contains(Cocktail.Alcohol.allCases[index])
        case .cocktail:
            clicked = (DATASTORE_COCKTAIL?.base == Cocktail.Alcohol.allCases[index])
        default:
            return nil
        }
        
        return clicked
    }
    
    // 버튼 누르면 그 상태를 저장
    func didTouchBannerToggleButton(didClicked: Bool) {
        
        switch self.registrationType {
        case .user: storeUserData(didClicked: didClicked)
        case .cocktail: storeCocktailData(didClicked: didClicked)
        default: break
        }
    }
    
    // 유저 등록 데이터스토어
    func storeUserData(didClicked: Bool) {
        
        if didClicked {
            DATASTORE.user?.basePreference?.append(Cocktail.Alcohol.allCases[self.index])
        } else {
            guard let index = DATASTORE.user?.basePreference?.firstIndex(of: Cocktail.Alcohol.allCases[self.index])
            else { return }
            
            DATASTORE.user?.basePreference?.remove(at: index)
        }
    }
    
    // 칵테일 등록 데이터스토어
    func storeCocktailData(didClicked: Bool) {
        // 칵테일 베이스는 하나만 선택 가능하도록 함
        // 직전에 선택한 버튼은 상태는 false로 바꾸기
        if didClicked {
            BasePreferenceCollectionViewCell.lastButton?.banner.backgroundColor = #colorLiteral(red: 0.8110396266, green: 0.8110588193, blue: 0.8110484481, alpha: 1)
            BasePreferenceCollectionViewCell.lastButton?.buttonTitleLabel.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
            BasePreferenceCollectionViewCell.lastButton?.isClicked = false
            
            BasePreferenceCollectionViewCell.lastButton = bannerToggleButton
            
            DATASTORE_COCKTAIL?.base = Cocktail.Alcohol.allCases[self.index]
        } else {
            BasePreferenceCollectionViewCell.lastButton = nil
            DATASTORE_COCKTAIL?.base = nil
        }
    }
}
