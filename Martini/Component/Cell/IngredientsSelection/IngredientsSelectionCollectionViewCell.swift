//
//  IngredientsSelectionCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/08/26.
//

import UIKit

class IngredientsSelectionCollectionViewCell: UICollectionViewCell, BannerButtonDelegate {
    let bannerButton = BannerButton()
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
        self.addSubview(bannerButton)
        
        bannerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            bannerButton.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        bannerButton.delegate = self // 버튼 클릭했을때 데이터를 넘겨받아야 함
    }
    
    // 버튼 상태 (유지)초기화
    func configure(imageName: String, title: String, index: Int, registrationType: RegistrationType) {
        
        bannerButton.bannerImageView.image = UIImage(named: imageName)
        bannerButton.bannerLabel.text = title
        
        self.index = index
        self.registrationType = registrationType

        guard let clicked = initState() else { return }
        
        if clicked {
            bannerButton.backgroundColor = UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0)
        } else {
            bannerButton.backgroundColor = UIColor.systemGray2
        }
        
        bannerButton.isChecked = clicked
    }
    
    func initState() -> Bool? {
        
        let clicked: Bool?
        
        switch self.registrationType {
        case .user:
            clicked = DATASTORE.user?.ingredientPreference?.contains(Cocktail.Ingredients.allCases[self.index])
        case .cocktail:
            clicked = DATASTORE_COCKTAIL?.ingredients.contains(Cocktail.Ingredients.allCases[self.index])
        default:
           clicked = nil
        }
        
        return clicked
    }
    
    // 버튼 상태 저장
    func didTouchBannerButton(didClicked: Bool) {
        
        switch self.registrationType {
        case .user:
            storeUserData(didClicked: didClicked)
        case .cocktail:
            storeCocktailData(didClicked: didClicked)
        default:
            break
        }
    }
    
    // 유저 등록 데이터스토어
    func storeUserData(didClicked: Bool) {
        
        if didClicked {
            DATASTORE.user?.ingredientPreference?.append(Cocktail.Ingredients.allCases[self.index])
        } else {
            guard let index = DATASTORE.user?.ingredientPreference?
                    .firstIndex(of: Cocktail.Ingredients.allCases[self.index])
            else { return }
            
            DATASTORE.user?.ingredientPreference?.remove(at: index)
        }
    }
    
    // 칵테일 등록 데이터 스토어
    func storeCocktailData(didClicked: Bool) {
        
        if didClicked {
            DATASTORE_COCKTAIL?.ingredients.append(Cocktail.Ingredients.allCases[self.index])
        } else {
            guard let index = DATASTORE_COCKTAIL?.ingredients
                    .firstIndex(of: Cocktail.Ingredients.allCases[self.index])
            else { return }
            
            DATASTORE_COCKTAIL?.ingredients.remove(at: index)
        }
    }
}
