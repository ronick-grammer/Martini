
//
//  StrenthSlider.swift
//  Martini
//
//  Created by RONICK on 2021/08/14.
//

import UIKit

class SliderStrenth: UIView {
    
    var slider = CustomStrenthSlider()
    var textTitle = UILabel()
    var textPercentage = UILabel()
    
    override func awakeFromNib() {
        self.addSubview(slider)
        self.addSubview(textTitle)
        self.addSubview(textPercentage)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        slider.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        textTitle.widthAnchor.constraint(equalTo: slider.widthAnchor).isActive = true
        textTitle.heightAnchor.constraint(equalTo: slider.heightAnchor).isActive = true
//        textTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 60 / 2).isActive = true
        
        textTitle.text = "단맛이 강한 음료가 좋습니다"
        textTitle.textAlignment = .center
        textTitle.font = UIFont.systemFont(ofSize: 20)
        textTitle.bounds.size = CGSize(width: 60, height: 60)
        textTitle.clipsToBounds = true
        
        print("slider height: \(slider.trackRect(forBounds: bounds).height / 2)")
        print("texttitle height: \(textTitle.bounds.size.height)")
        
        textPercentage.translatesAutoresizingMaskIntoConstraints = false
        textPercentage.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        textPercentage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textPercentage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textPercentage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        textPercentage.text = "hey"
        
        slider.maximumTrackTintColor = .red
        slider.minimumTrackTintColor = .white
        slider.setThumbImage(UIImage(), for: .normal)
        
        slider.setMinimumTrackImage(getImageWithColor(color:  UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0), size: slider.frame.size).resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3), resizingMode: .stretch), for: .normal)
        
        slider.setMaximumTrackImage(getImageWithColor(color: UIColor(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), size: slider.frame.size).resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3), resizingMode: .stretch), for: .normal)
        
      
        let tapGestureRecognizer = UITapGestureRecognizer(target: slider.superview, action: #selector(sliderTapped(_:)))

        slider.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // 탭 한 부위로 슬라이더 값 설정
    @objc func sliderTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        textPercentage.text = String(slider.value)
        
        let pointTapped: CGPoint = gestureRecognizer.location(in: slider.superview)

        let positionOfSlider: CGPoint = slider.frame.origin

        let widthOfSlider: CGFloat = slider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(slider.maximumValue) / widthOfSlider)

        slider.setValue(Float(newValue), animated: true)
    }
    
    
    // minimum Track 이미지, maximum Track 이미지 cornerRadius 적용
    private func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        
        let layer: CALayer =  CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layer.masksToBounds = true
        layer.cornerRadius = 6
        layer.backgroundColor = color.cgColor
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

