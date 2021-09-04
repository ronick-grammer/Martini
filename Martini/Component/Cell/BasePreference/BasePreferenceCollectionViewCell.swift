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
    func configure(imageName: String, title: String, index: Int) {
        bannerToggleButton.bannerImage.image = UIImage(named: imageName)
        bannerToggleButton.buttonTitleLabel.text = title
        
        self.index = index
        
        if PREFERENCE_DATASTORE.alcohols[index] {
            bannerToggleButton.banner.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)
            bannerToggleButton.buttonTitleLabel.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)
        } else {
            bannerToggleButton.banner.backgroundColor = #colorLiteral(red: 0.8110396266, green: 0.8110588193, blue: 0.8110484481, alpha: 1)
            bannerToggleButton.buttonTitleLabel.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        }
        
        bannerToggleButton.isClicked = PREFERENCE_DATASTORE.alcohols[index]
    }
    
    // 버튼 누르면 그 상태를 저장
    func didTouchBannerToggleButton(didClicked: Bool) {
        PREFERENCE_DATASTORE.alcohols[self.index] = didClicked
    }
}
