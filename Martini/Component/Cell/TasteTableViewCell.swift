//
//  TasteTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/26.
//

import UIKit

class TasteTableViewCell: UITableViewCell {
    
    @IBOutlet var tasteSV: UIStackView!
    
    static let nib: UINib = UINib(nibName: "TasteTableViewCell", bundle: nil)
    static let identifier = "TasteTableViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        tasteSV.layer.cornerRadius = 10
        tasteSV.isLayoutMarginsRelativeArrangement = true
        tasteSV.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 5)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //
    func addProgress(progressbar: TasteProgressView){
        
        tasteSV.addArrangedSubview(progressbar)
        
        
    }
    
}
