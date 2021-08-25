//
//  FlavorPreferenceCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/08/25.
//

import UIKit

class FlavorPreferenceCollectionViewCell: UICollectionViewCell {
    
    var sliderStrenth = SliderStrenth()
    
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
    }
    
    func configure(title: String) {
        sliderStrenth.labelTitle.text = title
    }
}
