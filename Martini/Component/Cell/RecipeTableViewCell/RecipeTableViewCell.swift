//
//  RecipeTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/29.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet var recipeSV: UIStackView!
    
    
    static let nib: UINib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
    static let identifier = "RecipeTableViewCell"
    
    var data:[String]? {
        didSet {
            if oldValue != data {
                recipeSV.arrangedSubviews.forEach { $0.removeFromSuperview() }
                data?.enumerated().forEach({ (key, value) in
                    addreipe(step: key, recipe: value)
                })
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        recipeSV.layer.cornerRadius = 10
        recipeSV.isLayoutMarginsRelativeArrangement = true
        recipeSV.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 5)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // 스택뷰로 레시피 추가
    func addreipe( step:Int, recipe: String){
        
        
        // horizontal 스택뷰
        let stackView = UIStackView()
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)

        
        
        stackView.axis = .horizontal
        stackView.contentMode = .scaleToFill
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 15
        


        let stepLabel = UILabel()
        
        
        stepLabel.text = "step \(step+1)"

        stackView.addArrangedSubview(stepLabel)
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true

        let receipeLabel = UILabel()

        receipeLabel.text = recipe
        receipeLabel.numberOfLines = 0
        receipeLabel.sizeToFit()
        
        stackView.addArrangedSubview(receipeLabel)
        recipeSV.addArrangedSubview(stackView)

        
        
    }
    
}
