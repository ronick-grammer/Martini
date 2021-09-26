//
//  CustomTableView.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/09/24.
//

import UIKit

class CustomTableView: UIView {
    
    let tableView = UITableView()
    var data:Cocktail?
    
    func initView() {
        self.tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier) // 셀 등록
        
        self.tableView.register(MainAttributeTableViewCell.nib, forCellReuseIdentifier: MainAttributeTableViewCell.identifier)
        
        self.tableView.register(ingredientTableViewCell.nib, forCellReuseIdentifier: ingredientTableViewCell.identifier)
        
        self.tableView.register(TasteTableViewCell.nib, forCellReuseIdentifier: TasteTableViewCell.identifier)
        
        self.tableView.register(RecipeTableViewCell.nib, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
