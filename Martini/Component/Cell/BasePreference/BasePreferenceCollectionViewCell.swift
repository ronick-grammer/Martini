//
//  BasePreferenceCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/08/22.
//

import UIKit

class BasePreferenceCollectionViewCell: UICollectionViewCell {
    
    let bannerToggleButton = BannerToggleButton()
    
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
        
        NSLayoutConstraint.activate([
            bannerToggleButton.topAnchor.constraint(equalTo: self.topAnchor),
            bannerToggleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bannerToggleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bannerToggleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configure(fileName: String, alcolName: String) {
        bannerToggleButton.bannerImage.image = UIImage(named: fileName)
        bannerToggleButton.buttonTitleLable.text = alcolName
    }
}
