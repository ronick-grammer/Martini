//
//  LikeButton.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import UIKit

class LikeButton: UIButton {
    
    var isLike:Bool = false
    
    @objc func likeButtonHandler(_ sender: UIButton) {
        isLike.toggle()
        if isLike {
            self.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            self.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        self.setTitle("12", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 90)
        self.setImage(UIImage(systemName: "star"), for: .normal)
        self.addTarget(self, action: #selector(likeButtonHandler(_:)), for: .touchUpInside)
    }

}
