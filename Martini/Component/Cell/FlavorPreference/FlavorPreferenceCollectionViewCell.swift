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
