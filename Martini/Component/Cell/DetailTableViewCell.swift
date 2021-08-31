//
//  DetailTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/29.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    
    @IBOutlet var likeButton: LikeButton!
    
    @IBOutlet var imgView: WebImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    static let nib: UINib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        
    static let identifier = "DetailTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}