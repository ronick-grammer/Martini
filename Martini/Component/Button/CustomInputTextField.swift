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

    @objc func textFieldDidChange(textField: UITextField){
        
    }
    
    override func awakeFromNib() {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconView.image = UIImage(systemName: "person.fill")
        iconView.tintColor = .black
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        placeholder = "이름"
        self.backgroundColor = #colorLiteral(red: 0.7761746049, green: 0.7685815096, blue: 0.781961143, alpha: 1)
        self.layer.cornerRadius = 10

        self.borderStyle = BorderStyle.none
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)),
            for: UIControl.Event.editingChanged)
    }
    
}






    



    
