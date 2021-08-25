//
//  IngredientsSelectionCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/08/26.
//

import UIKit

class IngredientsSelectionCollectionViewCell: UICollectionViewCell {
    let bannerButton = BannerButton()
    
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
    }
    
    func configure(fileName: String, title: String) {
        bannerButton.bannerImageView.image = UIImage(named: fileName)
        bannerButton.bannerLabel.text = title
    }
}
