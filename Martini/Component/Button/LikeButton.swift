//
//  LikeButton.swift
//  Martini
//
//  Created by RONICK on 2021/08/12.
//

import UIKit

protocol LikeButtonDelegate {
    func didTouchLikeButton(isLiked: Bool)
}

class LikeButton: UIButton {
    
    var isLiked:Bool = false
    let buttonSize = 40
    
    var delegate: LikeButtonDelegate?
    
    @objc func likeButtonHandler(_ sender: UIButton) {
        isLiked.toggle()
        
        self.tintColor = isLiked ? UIColor.yellow : UIColor.white
        
        delegate?.didTouchLikeButton(isLiked: isLiked)
    }
    
    override func awakeFromNib() {
        
        initShape()
        
        self.addTarget(self, action: #selector(likeButtonHandler(_:)), for: .touchUpInside)
    }
    
    func initShape() {
        self.setTitle("", for: .normal)
        self.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        self.frame.size = CGSize(width: buttonSize, height: buttonSize)
        self.tintColor = UIColor.white
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .medium), forImageIn: .normal)
        self.layer.cornerRadius = CGFloat(buttonSize / 2)
        self.layer.backgroundColor = UIColor.lightGray.cgColor

    }
    
    func setColor(color: UIColor){
        self.tintColor = color
    }
}
