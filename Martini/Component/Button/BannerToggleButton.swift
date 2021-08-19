//
//  BannerToggleButton.swift
//  Martini
//
//  Created by 이상현 on 2021/08/15.
//

import UIKit

class BannerToggleButton: UIView {
    let vstackView = UIStackView()
    let buttonTitleLable = UILabel()
    let banner = UIView()
    let bannerButton = UIButton()
    var isClicked: Bool = false

    @objc func BannerToggleButtonHandler(_ sender: UIButton) {
        isClicked.toggle()
        
        if isClicked {
            // 붉은색
            banner.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)
            buttonTitleLable.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)

        } else {
            // 회색(기본)
            banner.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
            buttonTitleLable.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)


        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.addSubview(vstackView)
        bannerButton.addTarget(self, action: #selector(BannerToggleButtonHandler(_:)), for: .touchUpInside)
        vstackView.axis = .vertical
        vstackView.spacing = 7
        vstackView.distribution = .fill
        vstackView.translatesAutoresizingMaskIntoConstraints = false
        vstackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        vstackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vstackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vstackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        vstackView.addArrangedSubview(banner)
        banner.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        banner.layer.cornerRadius = 10
        vstackView.addArrangedSubview(buttonTitleLable)
        buttonTitleLable.text = "cocktail"
        buttonTitleLable.textAlignment = .center
        buttonTitleLable.clipsToBounds = true
        buttonTitleLable.layer.cornerRadius = 10
        buttonTitleLable.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        banner.addSubview(bannerButton)
        bannerButton.isEnabled = true
        bannerButton.translatesAutoresizingMaskIntoConstraints = false
        bannerButton.topAnchor.constraint(equalTo: banner.topAnchor).isActive = true
        bannerButton.leftAnchor.constraint(equalTo: banner.leftAnchor).isActive = true
        bannerButton.rightAnchor.constraint(equalTo: banner.rightAnchor).isActive = true
        bannerButton.bottomAnchor.constraint(equalTo: banner.bottomAnchor).isActive = true
        bannerButton.clipsToBounds = true
        bannerButton.layer.cornerRadius = 10

    }
    
    func setColor(color: UIColor){
        buttonTitleLable.backgroundColor = color
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
