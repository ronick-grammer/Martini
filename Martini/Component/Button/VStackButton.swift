//
//  VStackButton.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/20.
//

import UIKit

protocol VStackButtonDelegate {
    func stackButtonSelected (seletedButton: UIButton, vstackButton: VStackButton)
}

class VStackButton: UIView {
    
    let title = UILabel()
    let stackView = UIStackView()
    
    var delegate:VStackButtonDelegate?

    override func awakeFromNib() {
        title.text = "제목"
        self.addSubview(title)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    @objc func buttonSeleted(_ sender: UIButton){
        delegate?.stackButtonSelected(seletedButton: sender, vstackButton: self)
    }
    
    func addButton(name: String){
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.contentHorizontalAlignment = .left
        var inset = button.contentEdgeInsets
        inset.left = 10
        button.contentEdgeInsets = inset
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.addTarget(self, action: #selector(buttonSeleted(_:)), for: .touchUpInside)
        
        self.stackView.addArrangedSubview(button)
    }

}

