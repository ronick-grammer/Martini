//
//  MainAttributeTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/22.
//


// Todo
// 1. key 레이블  2. value 레이블 -> 넘겨주는 매개변수 개수 만큼 생성?

import UIKit

class MainAttributeTableViewCell: UITableViewCell {
    
    var keyLabel = UILabel()
    var view = UIView()
    var valueLabel = UILabel()
    
    
    
//    static let nib: UINib = UINib(nibName: "MainAttributeTableViewCell", bundle: nil)

//    static let identifier = "MainAttributeTableViewCell"
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        keyLabel.text = "도수"
        valueLabel.text = "20%"
        valueLabel.backgroundColor = UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0)
        view.backgroundColor = .systemGray2
        
        
        view.layer.cornerRadius = 10
        
        
        self.addSubview(view)
        view.addSubview(keyLabel)
        view.addSubview(valueLabel)
        
        
        
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        view.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -170).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        keyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        keyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        valueLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
        
    }
    
   
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // do not anything
    }
    
    
    
    
}
