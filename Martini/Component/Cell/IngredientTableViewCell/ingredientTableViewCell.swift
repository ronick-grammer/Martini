//
//  ingredientTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/26.
//

import UIKit

class ingredientTableViewCell: UITableViewCell {

    
    @IBOutlet var ingredientSV: UIStackView!
    @IBOutlet var ingredientView: UIView!
    
    static let nib: UINib = UINib(nibName: "ingredientTableViewCell", bundle: nil)
        
    static let identifier = "ingredientTableViewCell"
    
    var data:[Cocktail.Ingredients]? {
        didSet {
            if oldValue != data {
                ingredientSV.arrangedSubviews.forEach { $0.removeFromSuperview() }
                
                data?.forEach({ addLabel(name: $0.rawValue) })
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ingredientView.layer.cornerRadius = 10
   
        ingredientSV.isLayoutMarginsRelativeArrangement = true
        ingredientSV.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //label 을 스택뷰에 추가
    func addLabel(name: String){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 150))
        label.adjustsFontSizeToFitWidth = true
        
        label.text = name
        label.backgroundColor = UIColor(red: (232/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.5)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center

        
        ingredientSV.addArrangedSubview(label)
    }
    
}
