//
//  CustomInputImageView.swift
//  Martini
//
//  Created by 이상현 on 2021/08/15.
//

import UIKit

class CustomInputImageView: UIImageView {
    @objc func likeButtonHandler(_ sender: UIImageView) {
    }
    var CustomInputImageView = UIImageView()
    
    override func awakeFromNib() {
        CustomInputImageView.image = UIImage(named: "CustomInput.png")
    }
    
    


}
