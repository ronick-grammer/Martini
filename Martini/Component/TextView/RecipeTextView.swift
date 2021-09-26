//
//  RecipeTextView.swift
//  Martini
//
//  Created by RONICK on 2021/09/18.
//

import UIKit

class RecipeTextView: UIView {
    
    let hStackView : UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.alignment = .fill
        hstack.distribution = .fill
        hstack.spacing = 5
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        return hstack
    }()
    
    var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var recipeTextView: UITextView = {
        let textView = UITextView()
        textView.keyboardType = .namePhonePad
        textView.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.layer.cornerRadius = 10
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.addSubview(hStackView)
        hStackView.addArrangedSubview(numberLabel)
        hStackView.addArrangedSubview(recipeTextView)
        
        NSLayoutConstraint.activate([
            hStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            hStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            numberLabel.widthAnchor.constraint(equalToConstant: 60),
            numberLabel.heightAnchor.constraint(equalTo: hStackView.heightAnchor),
            
            recipeTextView.widthAnchor.constraint(equalToConstant: 100),
            recipeTextView.heightAnchor.constraint(equalTo: hStackView.heightAnchor)
        ])
    }
    
    func configure(number: String) {
        numberLabel.text = number
    }
}
