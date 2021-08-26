//
//  BannerButton.swift
//  Martini
//
//  Created by 최예주 on 2021/08/17.
//
import UIKit

@IBDesignable

class BannerButton: UIView {
    
    @IBInspectable var customerImage:UIImage? = UIImage(named: "cocktail_icon")
    @IBInspectable var customerText:String? = "Orange"
    var isChecked: Bool = false
    var bannerImageView = UIImageView()
    var bannerLabel = UILabel()
    var bannerButton = UIButton()
    
    func setupView(){
        self.addSubview(bannerImageView)
        self.addSubview(bannerLabel)
        self.addSubview(bannerButton)
        
        // 레이아웃 셋팅
        configureBannerLabel()
        configureBannerButton()
        configureBannerImageView()
    
         
        // 이미지, text 설정
        bannerImageView.image = self.customerImage
        bannerLabel.text = customerText
        
        self.backgroundColor = UIColor.systemGray2
        self.layer.cornerRadius = 15
        
        bannerButton.addTarget(self, action: #selector(bannerSelected), for: .touchUpInside)
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    // Label 초기 셋팅
    func configureBannerLabel(){
        bannerLabel.textAlignment = .center
        bannerLabel.font = UIFont.systemFont(ofSize: CGFloat(20))  // 폰트 크기
        
        bannerLabel.adjustsFontSizeToFitWidth = true //autoshrink -> 글자가 길면 폰트 사이즈 줄이도록
        bannerLabel.minimumScaleFactor = 0.5 // 폰트 최소 크기
        
        //autolayout
        bannerLabel.translatesAutoresizingMaskIntoConstraints = false
        bannerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bannerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bannerLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bannerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
    // ImageView 초기 셋팅
    func configureBannerImageView(){
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false

        bannerImageView.topAnchor.constraint(equalTo: self.topAnchor , constant: 10).isActive = true
        bannerImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        bannerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true

        bannerImageView.bottomAnchor.constraint(equalTo: bannerLabel.topAnchor, constant: -10).isActive = true
    }
    
    
    // Button 초기 셋팅
    func configureBannerButton(){
        
        bannerButton.translatesAutoresizingMaskIntoConstraints = false
        bannerButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bannerButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    

    
    //
    @objc
    func bannerSelected(_ sender : UIButton){
        isChecked.toggle()
                
        if isChecked{
            self.backgroundColor = UIColor.systemGray2
        }
        else{
            self.backgroundColor = UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0)
            }
        }
            

   

}
