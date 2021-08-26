//
//  ingredientsTableViewCell.swift
//  Martini
//
//  Created by 최예주 on 2021/08/26.
//

// 재료 테이블뷰 셀
import UIKit

class ingredientsTableViewCell: UITableViewCell {

    
    var ingredients = ["Vodka","Jin","Orange"]
    
    var keyLabel = UILabel()
    var view = UIView()
//    var valueLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // 레이블 추가 함수
//    func addLabel(name: String){
//
//        let label = UILabel()
//        label.text = name
//
//        label.backgroundColor = .systemGray4
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.systemGray2.cgColor
//
//        self.view.addArrangedSubview(label)
//
//    }
    
    
    func setLayout(){
        
        
        keyLabel.text = "재료"
            
        
        
    
//        valueLabel.backgroundColor = UIColor(red: (240/255.0), green: (158/255.0), blue: (158/255.0), alpha: 1.0)
        view.backgroundColor = .systemGray2
        
        
        view.layer.cornerRadius = 10
        
        
        self.addSubview(view)
        view.addSubview(keyLabel)
        
        
        
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        view.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -170).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        keyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        keyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
