//
//  LoginButton.swift
//  Martini
//
//  Created by 이상현 on 2021/08/18.
//

import UIKit

protocol LoginButtonDelegate {
    func LoginButtonHandler(_ sender: UIButton)
}
class LoginButton: UIButton {
    var delegate: LoginButtonDelegate?
    var isClicked: Bool = false
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == true {
                self.layer.opacity = 0.5
            } else {
                self.layer.opacity = 1
            }
        }
    }
    
    @objc func LoginButtonHandler(_ sender: UIButton) {
       
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
        self.addTarget(self, action: #selector(LoginButtonHandler(_:)), for: .touchUpInside) // self로
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = COLOR_MARTINI.button_normal
        informTextInfo(text: "default", fontSize: 30)
    }

    func informTextInfo(text: String, fontSize: Int) {
        let text = text
        // text를 NSMutableAttribute를 만듦
        let textInfo = NSMutableAttributedString(string: text)
        // text 색지정
        let textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // 색과 언더 라인을 추가
//        textInfo.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: text.count))
        textInfo.addAttributes([NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(fontSize))], range: NSRange(location: 0, length: text.count))
        // 버튼 속성 적용
        self.setAttributedTitle(textInfo, for: .normal)
        // 버튼 값 적용
    }

    
    func setColor(color: UIColor){
        self.backgroundColor = color
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

