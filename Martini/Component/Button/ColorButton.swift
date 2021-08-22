//
//  ColorButton.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/22.
//

import UIKit

class ColorButton: UIView {
    
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func setupLayout(){
        self.addSubview(colorView)
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: colorView.widthAnchor),
            button.heightAnchor.constraint(equalTo: colorView.heightAnchor),
            button.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: colorView.trailingAnchor),
            button.topAnchor.constraint(equalTo: colorView.topAnchor),
            button.bottomAnchor.constraint(equalTo: colorView.bottomAnchor),
            
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
