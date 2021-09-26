//
//  CockTailTableViewCell.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/14.
//

import UIKit
import Firebase

class CockTailTableViewCell: UITableViewCell, LikeButtonDelegate {
    
    static let nib: UINib = UINib(nibName: "CockTailTableViewCell", bundle: nil)
        
    static let identifier = "CockTailTableViewCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tasteLabel: UILabel!
    @IBOutlet weak var likeButton: LikeButton!
    
    var cocktailId: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 10
        cocktailImage.clipsToBounds = true
        cocktailImage.layer.cornerRadius = 50
        tasteLabel.clipsToBounds = true
        tasteLabel.layer.cornerRadius = 10
        
        likeButton.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    
    func configure(cocktailId: String) {
        self.cocktailId = cocktailId
    }
    
    func didTouchLikeButton(isLiked: Bool) {
        
        guard let cocktailId = self.cocktailId else { return }
        if isLiked {
            
            CocktailManager.shared.liked(cocktailId: cocktailId) { success, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
            }
        } else {
            CocktailManager.shared.unliked(cocktailId: cocktailId) { success, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
    
    
}
