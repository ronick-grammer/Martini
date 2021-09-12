//
//  TasteProgressView.swift
//  Martini
//
//  Created by 최예주 on 2021/08/17.
//

import UIKit


class TasteProgressView: UIView {

    var tasteLabel = UILabel()
    var tasteProgress = UIProgressView()
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setting()
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setting()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setting()
    
    }
    
    
    func setting(){
        self.addSubview(tasteLabel)
        self.addSubview(tasteProgress)
        
        // 현재 value 셋팅
        setProgressValue(0.4)
        

        // title
        tasteLabel.text = "Sweet"
        
        
        
        
        
        //layout
        tasteLabel.translatesAutoresizingMaskIntoConstraints = false
        tasteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tasteLabel.centerYAnchor.constraint(equalTo: tasteProgress.centerYAnchor).isActive = true
        tasteLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        
        tasteProgress.translatesAutoresizingMaskIntoConstraints = false
        tasteProgress.leadingAnchor.constraint(equalTo: tasteLabel.trailingAnchor, constant: 15).isActive = true
        tasteProgress.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tasteProgress.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tasteProgress.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  
        
        // 코너 둥글게
        
        tasteProgress.layer.cornerRadius = 16
        tasteProgress.clipsToBounds = true
        
  
 
    }
    
    
    
    
    // progressbar value 셋팅
    // 0.6을 넘길때 빨간색으로 변경
    func setProgressValue(_ value: Float){
        
        tasteProgress.setProgress(value, animated: false)
        
        
        if (value < 0.6) {

            tasteProgress.progressTintColor = UIColor(red: (12/255.0), green: (200/255.0), blue: (42/255.0), alpha: 0.5)
            tasteProgress.trackTintColor = UIColor(red: (125/255.0), green: (232/255.0), blue: (142/255.0), alpha: 0.5)
        }
        else {
            
            
            tasteProgress.progressTintColor = UIColor(red: (232/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.5)
            tasteProgress.trackTintColor = UIColor(red: (222/255.0), green: (116/255.0), blue: (116/255.0), alpha: 0.5)
            
        }
        
    }

}

