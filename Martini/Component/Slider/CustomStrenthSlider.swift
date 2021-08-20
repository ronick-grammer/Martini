//
//  customStrenthSlider.swift
//  Martini
//
//  Created by RONICK on 2021/08/18.
//

import UIKit

class CustomStrenthSlider: UISlider {
    
    override func awakeFromNib() {
    }
    
    // 슬라이더 탭 위치를 값으로 설정
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
}
