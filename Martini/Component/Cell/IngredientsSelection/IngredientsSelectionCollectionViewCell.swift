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
    func configure(imageName: String, title: String, index: Int) {
        bannerButton.bannerImageView.image = UIImage(named: imageName)
        bannerButton.bannerLabel.text = title
        self.index = index

        guard let clicked = DATASTORE.user?.ingredientPreference?.contains(Cocktail.Ingredients.allCases[index]) else {
            return
        }
        
        if clicked {
            bannerButton.backgroundColor = UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0)
        } else {
            bannerButton.backgroundColor = UIColor.systemGray2
        }
        
        bannerButton.isChecked = clicked
    }
    
    // 버튼 상태 저장
    func didTouchBannerButton(didClicked: Bool) {
        
        if didClicked {
            DATASTORE.user?.ingredientPreference?.append(Cocktail.Ingredients.allCases[self.index])
        } else {
            guard let index = DATASTORE.user?.ingredientPreference?.firstIndex(of: Cocktail.Ingredients.allCases[self.index]) else { return }
            DATASTORE.user?.ingredientPreference?.remove(at: index)
        }
    }
}
