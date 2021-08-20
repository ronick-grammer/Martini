//
//  CustomInputTextField.swift
//  Martini
//
//  Created by 이상현 on 2021/08/15.
//

import UIKit

@IBDesignable

class CustomInputTextField: UITextField  {
    var textName: String = ""
    let iconView = UIImageView(frame:
                                CGRect(x: 10, y: 5, width: 20, height: 20))
    let iconContainerView: UIView = UIView(frame:
                                            CGRect(x: 0, y: 0, width: 40, height: 30))
        
    @objc func textFieldDidChange(textField: CustomInputTextField){
        
    }
    
    override func awakeFromNib() {
        iconView.tintColor = .black
        iconView.image = UIImage(systemName: "star.fill")
        self.placeholder = "default"
        iconContainerView.addSubview(iconView)

        leftView = iconContainerView
        leftViewMode = .always
        
        self.backgroundColor = #colorLiteral(red: 0.7761746049, green: 0.7685815096, blue: 0.781961143, alpha: 1)
        self.layer.cornerRadius = 10
        self.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        self.borderStyle = BorderStyle.none
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)),
            for: UIControl.Event.editingChanged)
    }
    
    func InformTextInfo(placeholder: String = "default", iconName: String = "person.fill") {
        iconView.image = UIImage(systemName: iconName)
        self.placeholder = placeholder
    }
}






    



    
