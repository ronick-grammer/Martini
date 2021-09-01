//
//  IngredientsSelectionCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/08/26.
//

import UIKit

class IngredientsSelectionCollectionViewCell: UICollectionViewCell, BannerButtonDelegate {
    let bannerButton = BannerButton()
    var ingredient = Cocktail.Ingredients.none
    
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
    func configure(imageName: String, title: String, ingredient: Cocktail.Ingredients) {
        bannerButton.bannerImageView.image = UIImage(named: imageName)
        bannerButton.bannerLabel.text = title
        self.ingredient = ingredient
        
        if PreferenceDataStore.ingredients[ingredient.rawValue] {
            bannerButton.backgroundColor = UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0)
        } else{
            bannerButton.backgroundColor = UIColor.systemGray2
        }
        
        bannerButton.isChecked = PreferenceDataStore.ingredients[ingredient.rawValue]
    }
    
    // 버튼 상태 저장
    func didTouchBannerButton(didClicked: Bool) {
        PreferenceDataStore.ingredients[ingredient.rawValue] = didClicked
    }
}
