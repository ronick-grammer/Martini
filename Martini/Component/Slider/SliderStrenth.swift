
//
//  StrenthSlider.swift
//  Martini
//
//  Created by RONICK on 2021/08/14.
//

import UIKit

protocol SliderStrenthDelegate {
    func didChangeValue(value: Double)
}

class SliderStrenth: UIView {
    
    var slider = UISlider()
    var labelTitle = UILabel()
    var labelPercentage = UILabel()
    
    var delegate: SliderStrenthDelegate?
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        print(#function)
//        setUpLayout()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLayout()
        setMinMaxTrackImage(size: slider.frame.size)
    }
    
    func setUpLayout() {
        self.addSubview(slider)
        self.addSubview(labelPercentage)
        
        configureSlider()
        configureLabelTitle()
        configureLabelPercentage()
    }
    
    func configureSlider() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        slider.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // 슬라이더 트랙 사이즈 설정(뷰 크기에 맞춤)
        slider.frame.size = CGSize(width: self.frame.size.width, height: self.frame.height)
        
        // ThumbImage 보이지 않기
        slider.setThumbImage(UIImage(), for: .normal)
        
        // 슬라이더 제스쳐 이벤트 설정
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        slider.addGestureRecognizer(tapGestureRecognizer)
        
        slider.addTarget(self, action: #selector(valueChange), for: .valueChanged)
    }
    
    @objc func valueChange(_ sender: UISlider) {
        labelPercentage.text = "\(round(slider.value * 50.0))%"
        
        if delegate != nil {
            delegate?.didChangeValue(value: Double(slider.value * 50.0))
        }
    }
    
    func configureLabelTitle() {

        slider.addSubview(labelTitle) // 슬라이더 안에 글자 타이틀 겹침
        labelTitle.text = "텍스트를 넣어주세요"
        
        // 슬라이더 트랙 사이즈와 같게 해서 중앙에 위치시킴
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelTitle.widthAnchor.constraint(equalTo: slider.widthAnchor),
            labelTitle.heightAnchor.constraint(equalTo: slider.heightAnchor)
        ])
        
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    func configureLabelPercentage() {
        labelPercentage.translatesAutoresizingMaskIntoConstraints = false
        labelPercentage.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: -20).isActive = true
        labelPercentage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelPercentage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        labelPercentage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        labelPercentage.text = "0%"
        labelPercentage.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        labelPercentage.textColor = .white
        labelPercentage.textAlignment = .center
    }
    
    // 슬라이더 가장 자리 둥글게 만들기
    func setMinMaxTrackImage(size: CGSize) {
        slider.setMinimumTrackImage(getImageWithColor(color:  UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0), size: size).resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3), resizingMode: .stretch), for: .normal)
        
        slider.setMaximumTrackImage(getImageWithColor(color: UIColor(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), size: size).resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3), resizingMode: .stretch), for: .normal)
    }
    
    // minimum Track 이미지, maximum Track 이미지 cornerRadius 적용
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        // 형태 설정
        let layer: CALayer =  CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.backgroundColor = color.cgColor
        
        // 설정한 형태를 기반으로 이미지 생성
        /* *** 중요 ***
         size의 width 나 height 둘중 하나라도 0이라면 nil을 반환하여 실행 오류생김.
         때문에 getImageWidthColor 함수는 슬라이더의 size를 확실히 할당한 후 호출되어야 함
         */
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    // 탭 한 부위로 슬라이더 값 설정
    @objc func sliderTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: slider)

        let positionOfSlider: CGPoint = slider.frame.origin

        let widthOfSlider: CGFloat = slider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(slider.maximumValue) / widthOfSlider)

        slider.setValue(Float(newValue), animated: true)
        labelPercentage.text = "\(round(slider.value * 50.0))%"
        
        if delegate != nil {
            delegate?.didChangeValue(value: Double(slider.value * 50.0))
        }
    }
}

