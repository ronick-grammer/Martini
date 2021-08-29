//
//  MainTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var imgView: WebImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    static let nib: UINib = UINib(nibName: "MainTableViewCell", bundle: nil)
        
    static let identifier = "MainTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // DetailView로 넘어가기

        
    }
    
}
