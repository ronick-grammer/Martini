//
//  CustomInputView.swift
//  Martini
//
//  Created by 이상현 on 2021/08/15.
//

import UIKit

class CustomInputView: UIView {
    
    override func awakeFromNib() {
        let imageName = "CustomInput.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        self.addSubview(imageView)
        //Imageview on Top of View
        self.bringSubviewToFront(imageView)
    }
}

