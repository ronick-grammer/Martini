//
//  BannerToggleButton.swift
//  Martini
//
//  Created by 이상현 on 2021/08/15.
//

import UIKit

protocol BannerToggleButtonDelegate {
    func didTouchBannerToggleButton(didClicked: Bool)
    
}

class BannerToggleButton: UIView {
    let vstackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 7
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "cocktail"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = COLOR_MARTINI.button_normal
        return label
    }()
    
    let banner: UIView = {
        let view = UIView()
        view.backgroundColor = COLOR_MARTINI.button_normal
        view.layer.cornerRadius = 10
        return view
    }()
    
    let bannerButton: UIButton = {
        let button = UIButton()
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    var bannerImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cocktail_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var isClicked: Bool = false
    var delegate: BannerToggleButtonDelegate?
    
    @objc func BannerToggleButtonHandler(_ sender: UIButton) {
        isClicked.toggle()
        delegate?.didTouchBannerToggleButton(didClicked: isClicked)
        if isClicked {
            // 붉은색
            banner.backgroundColor = COLOR_MARTINI.button_clickable
            buttonTitleLabel.backgroundColor = COLOR_MARTINI.button_clickable
            
        } else {
            // 회색(기본)
            banner.backgroundColor = COLOR_MARTINI.button_normal
            buttonTitleLabel.backgroundColor = COLOR_MARTINI.button_normal
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func setupLayout() {
        self.addSubview(vstackView)
        
        bannerButton.addTarget(self, action: #selector(BannerToggleButtonHandler(_:)), for: .touchUpInside)
        vstackView.addArrangedSubview(banner)
        vstackView.addArrangedSubview(buttonTitleLabel)
        banner.addSubview(bannerImage)
        self.addSubview(bannerButton)
        NSLayoutConstraint.activate([
            vstackView.topAnchor.constraint(equalTo: self.topAnchor),
            vstackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            vstackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bannerImage.topAnchor.constraint(equalTo: banner.topAnchor, constant: 10),
            bannerImage.leftAnchor.constraint(equalTo: banner.leftAnchor, constant: 10),
            bannerImage.rightAnchor.constraint(equalTo: banner.rightAnchor, constant: -10),
            bannerImage.bottomAnchor.constraint(equalTo: banner.bottomAnchor, constant: -10),
            bannerButton.topAnchor.constraint(equalTo: self.topAnchor),
            bannerButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            bannerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            banner.topAnchor.constraint(equalTo: self.topAnchor),
            banner.widthAnchor.constraint(equalTo: self.widthAnchor),
            banner.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
    
    func setColor(color: UIColor){
        buttonTitleLabel.backgroundColor = color
    }
}
