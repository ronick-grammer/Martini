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
        label.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        return label
    }()
    
    let banner: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7641277313, green: 0.7674344182, blue: 0.7642211318, alpha: 1)
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
            banner.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)
            buttonTitleLabel.backgroundColor = #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1)

        } else {
            // 회색(기본)
            banner.backgroundColor = #colorLiteral(red: 0.8110396266, green: 0.8110588193, blue: 0.8110484481, alpha: 1)
            buttonTitleLabel.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
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
