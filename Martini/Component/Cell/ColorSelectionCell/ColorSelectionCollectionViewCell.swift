//
//  ColorSelectionCollectionViewCell.swift
//  Martini
//
//  Created by RONICK on 2021/09/18.
//

import UIKit

class ColorSelectionCollectionViewCell: UICollectionViewCell {
    
    var colorButton = ColorButton()
    var index = Int()
    var clicked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.addSubview(colorButton)
        
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            colorButton.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        colorButton.colorView.layer.cornerRadius = 8
        
        colorButton.button.tintColor = .white
        colorButton.button.addTarget(self, action: #selector(didClick), for: .touchUpInside)
    }
    
    func configure(color: UIColor, index: Int) {
        
        colorButton.colorView.backgroundColor = color
        self.index = index
        
        guard let clicked = DATASTORE_COCKTAIL?.color.contains(Cocktail.Color.allCases[index]) else { return }
        
        if clicked {
            colorButton.button.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)), for: .normal)
        }
        else {
            colorButton.button.setImage(UIImage(), for: .normal)
        }
        
        self.clicked = clicked
    }
    
    
    @objc func didClick(){
        
        self.clicked = !self.clicked
        print(self.clicked)
        if self.clicked {
            colorButton.button.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)), for: .normal)
            
            DATASTORE_COCKTAIL?.color.append(Cocktail.Color.allCases[self.index])
        }
        else {
            colorButton.button.setImage(UIImage(), for: .normal)
            
            guard let index = DATASTORE_COCKTAIL?.color.firstIndex(of: Cocktail.Color.allCases[self.index])
            else { return }
            
            DATASTORE_COCKTAIL?.color.remove(at: index)
        }
    }
}
