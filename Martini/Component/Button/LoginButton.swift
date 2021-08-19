//
//  LoginButton.swift
//  Martini
//
//  Created by 이상현 on 2021/08/18.
//

import UIKit

class LoginButton: UIButton {
    let buttonTitleLable = UILabel()
    let Button = UIButton()
    var isClicked: Bool = false

//    @objc func LoginButtonHandler(_ sender: UIButton) {
//        isClicked.toggle()
//        if isClicked == true {
//            Button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
//        } else {
//            Button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        Button.isUserInteractionEnabled = false
//        Button.addTarget(self, action: #selector(LoginButtonHandler(_:)), for: .touchUpInside)
        
        self.addSubview(Button)
        Button.isEnabled = true
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Button.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        Button.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        Button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        Button.clipsToBounds = true
        Button.layer.cornerRadius = 10
        Button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        InformTextInfo(text: "default", fontSize: 30)
    }

    func InformTextInfo(text: String, fontSize: Int) {
        let text = text
        // text를 NSMutableAttribute를 만듦
        let textInfo = NSMutableAttributedString(string: text)

        // text 색지정
        let textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // 색과 언더 라인을 추가
//        textInfo.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: text.count))
        textInfo.addAttributes([NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(fontSize))], range: NSRange(location: 0, length: text.count))
        // 버튼에 적용
        Button.setAttributedTitle(textInfo, for: .normal)
    }

    
//    func setColor(color: UIColor){
//        buttonTitleLable.backgroundColor = color
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

