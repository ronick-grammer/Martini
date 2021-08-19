//
//  customStrenthSlider.swift
//  Martini
//
//  Created by RONICK on 2021/08/18.
//

import UIKit

class CustomStrenthSlider: UISlider {
    
//    var textTitle = UILabel()
    
    override func awakeFromNib() {
        
//
//        self.addSubview(textTitle)
//        textTitle.text = "단맛이 좋아요"
//        textTitle.textAlignment = .center
//        textTitle.center = CGPoint(x: trackRect(forBounds: bounds).midX, y: trackRect(forBounds: bounds).midY)
//        textTitle.layer.zPosition = 1
        
        
    }
    
//    override func trackRect(forBounds bounds: CGRect) -> CGRect {
//        var result = super.trackRect(forBounds: bounds)
//        result.size.width = bounds.size.width
//        result.size.height = 30
//        print("\(result.size.width)")
//        return result
//    }
    
    
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: 75))
    }
    
    
    
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        print("value: \(value)")
//        return true
//    }
//    

    
    
}
