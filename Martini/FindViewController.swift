//
//  FindViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/20.
//

import UIKit

class FindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let baseButtons = ["Rum", "Vodka", "Gin"]
    let flavors = ["단맛이 강한", "부드러운 맛", "술맛이 강한", "새로운 맛"]
    let colors:[UIColor] = [.systemRed, .systemGreen, .systemBlue, .systemTeal, .systemPink, .systemOrange, .systemTeal]
    let ingredients = ["Rum", "Vodka", "Gin", "Orange"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "findViewCell", for: indexPath) as! FindViewCell
        baseButtons.forEach { base in
            cell.bases.addButton(name: base)
        }
        flavors.forEach { flavor in
            cell.flavor.addButton(name: flavor)
        }
        
        colors.forEach { color in
            let view = ColorButton()
            view.colorView.backgroundColor = color
            cell.colors.addArrangedSubview(view)
        }
        
        ingredients.forEach { ingredient in
            let banner = BannerButton()
            banner.bannerLabel.text = ingredient
            cell.ingredient.addArrangedSubview(banner)
        }
        
        return cell
    }


}



class FindViewCell: UITableViewCell {
    
    @IBOutlet weak var bases: VStackButton!
    @IBOutlet weak var flavor: VStackButton!
    @IBOutlet weak var alcoholFind: UIButton!
    @IBOutlet weak var colors: UIStackView!
    @IBOutlet weak var ingredient: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        alcoholFind.layer.cornerRadius = 5
//        colors.spacing = 1
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
