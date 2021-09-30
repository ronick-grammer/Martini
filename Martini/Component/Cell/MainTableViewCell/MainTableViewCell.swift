
//  MainTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/22.
//

import UIKit

class MainTableViewCell: UITableViewCell, LikeButtonDelegate {
    

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var imgView: WebImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var likeButton: LikeButton!
    
    static let nib: UINib = UINib(nibName: "MainTableViewCell", bundle: nil)
        
    static let identifier = "MainTableViewCell"
    
    var cocktailID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        likeButton.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // DetailView로 넘어가기

        
    }
    
    func configure(cocktailID: String?) {
        guard let oid = cocktailID else { return }
        self.cocktailID = oid
        
        CocktailManager.shared.checkIfUserLiked(cocktailID: oid) { isLiked, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
            
            if let isLiked = isLiked {
                isLiked ? self.likeButton.setColor(color: .yellow) : self.likeButton.setColor(color: .white)
                self.likeButton.isLiked = isLiked
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
            CocktailManager.shared.unliked(cocktailId: cocktailID) { success, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
    
}
