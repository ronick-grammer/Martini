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
    
    @IBOutlet var strengthLabel: UILabel!
    
    @IBOutlet var view: UIView!
    
    
    static let nib: UINib = UINib(nibName: "MainAttributeTableViewCell", bundle: nil)
        
    static let identifier = "MainAttributeTableViewCell"
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        strengthLabel.layer.cornerRadius = 10
        view.layer.cornerRadius = 10
        
       
        
        
        
        
    }
    
   
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // do not anything
    }
    
    
    
    
}
