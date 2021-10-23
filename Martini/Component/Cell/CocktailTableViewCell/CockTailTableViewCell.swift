
//  CockTailTableViewCell.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/14.
//

import UIKit
import Firebase

protocol CocktailTableViewCellDelegate {
    func deleteLikedCocktail(likeButton: UIButton)
}

class CockTailTableViewCell: UITableViewCell, LikeButtonDelegate {
    
    static let nib: UINib = UINib(nibName: "CockTailTableViewCell", bundle: nil)
        
    static let identifier = "CockTailTableViewCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cocktailImage: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tasteLabel: UILabel!
    @IBOutlet weak var likeButton: LikeButton!
    
    var cocktailId: String?
    var delegate: CocktailTableViewCellDelegate?
    
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
    
    func configure(cocktailID: String?) {
        guard let oid = cocktailID else { return }
        self.cocktailId = oid
        
        CocktailManager.shared.checkIfUserLiked(cocktailID: oid) { [weak self] isLiked, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
            
            if let isLiked = isLiked {
                isLiked ? self?.likeButton.setColor(color: .yellow) : self?.likeButton.setColor(color: .white)
                self?.likeButton.isLiked = isLiked
            }
        }
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
            CocktailManager.shared.unliked(cocktailId: cocktailId) { [weak self] success, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                
                if let delegate = self?.delegate, let likeButton = self?.likeButton {
                    delegate.deleteLikedCocktail(likeButton: likeButton)
                }
            }
        }
    }
    
}
