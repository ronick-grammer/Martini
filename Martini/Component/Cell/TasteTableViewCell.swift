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
    
    var data:[Cocktail.Taste : Int]? {
        didSet {
            if oldValue != data {
                tasteSV.arrangedSubviews.forEach { $0.removeFromSuperview() }
                data?.forEach({
                    let progress = TasteProgressView()
                    progress.tasteLabel.text = $0.rawValue
                    progress.tasteProgress.progress = Float($1)
                    addProgress(progressbar: progress, taste: $0.rawValue, value: Float($1)*0.01)
                })
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        tasteSV.layer.cornerRadius = 10
        tasteSV.isLayoutMarginsRelativeArrangement = true
        tasteSV.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 5)
        tasteSV.spacing = 5
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //
    func addProgress(progressbar: TasteProgressView, taste: String, value: Float){
        tasteSV.addArrangedSubview(progressbar)
        progressbar.setProgressValue(value)
        progressbar.tasteLabel.text = taste
        
        
    }
    
}
