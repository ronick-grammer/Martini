//
//  CustomInputTextField.swift
//  Martini
//
//  Created by 이상현 on 2021/08/15.
//

import UIKit

class CustomInputTextField: UITextField  {
    let iconView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    let iconContainerView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: 40, height: 30))
        return view
    }()
    
    @objc func textFieldDidChange(textField: CustomInputTextField){
        
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
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.placeholder = "default"
        self.backgroundColor = COLOR_MARTINI.textBox
        self.layer.cornerRadius = 10
        self.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        self.borderStyle = BorderStyle.none
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)),
            for: UIControl.Event.editingChanged)
    }
    
    func informTextInfo(placeholder: String = "default", iconName: String = "person.fill") {
        iconView.image = UIImage(systemName: iconName)
        self.placeholder = placeholder
    }
}
