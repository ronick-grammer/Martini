//
//  BannerFootLabelButton.swift
//  Martini
//
//  Created by 이상현 on 2021/08/15.
//

import UIKit

class BannerFootLabelButton: UIButton {
    var isClicked: Bool = false
    
    @objc func BannerFootLabelButtonHandler(_ sender: UIButton) {
        isClicked.toggle()
        
        if isClicked {
            // 붉은색
            self.setImage(UIImage(named: "BannerFootLabelButton.fill"), for: .normal)
        } else {
            // 회색(기본)
            self.setImage(UIImage(named: "BannerFootLabelButton"), for: .normal)

        }
    }
    
    override func awakeFromNib() {
        let text = "Vodka"
        // text를 NSMutableAttribute를 만듦
        let textInfo = NSMutableAttributedString(string: text)
        // text 색지정
        let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        // 색과 언더 라인을 추가
        textInfo.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: text.count))
        // 버튼에 적용 (inspector에서 Attribute로 설정해주기)
        self.setAttributedTitle(textInfo, for: .normal)
        // 기본 이미지를 회색으로 선언
        self.setImage(UIImage(named: "BannerFootLabelButton"), for: .normal)
        self.addTarget(self, action: #selector(BannerFootLabelButtonHandler(_:)), for: .touchUpInside)
        // 버튼내부의 text 패딩
        self.titleEdgeInsets  = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 85)
        // UIButton.imageEdgeInsets = UIEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) // 버튼 내부의 text 패딩
    }

}


