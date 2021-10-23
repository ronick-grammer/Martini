
//  DetailTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/29.
//

import UIKit

class DetailTableViewCell: UITableViewCell, LikeButtonDelegate {

    
    @IBOutlet var likeButton: LikeButton!
    
    @IBOutlet var imgView: WebImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    static let nib: UINib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        
    static let identifier = "DetailTableViewCell"
    
    var cocktailID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        likeButton.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(cocktailID: String?){
        
        guard let oid = cocktailID else { return }
        self.cocktailID = oid
        
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
        guard let cocktailID = self.cocktailID else { return }
        
        if isLiked {
            CocktailManager.shared.liked(cocktailId: cocktailID) { success, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
            }
        } else {
            CocktailManager.shared.unliked(cocktailId: cocktailID) { sucess, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
    
}
