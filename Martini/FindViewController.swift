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
    var baseButtons2:[String] = []
    let colors:[UIColor] = [.systemRed, .systemGreen, .systemBlue, .systemTeal, .systemPink, .systemOrange, .systemTeal]
    let ingredients = ["Rum", "Vodka", "Gin", "Orange"]
    
//    var data:Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for type in Cocktail.Alcohol.allCases{
            baseButtons2.append("\(type)")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Find"
        // Do any additional setup after loading the view.
    }
    
    @objc func alcholFindHandler(){
        let vc = initViewController("Search", identfire: "SearchView") as! SearchViewController
        vc.searchBar = false
        vc.navigationItem.title = "조건검색"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "findViewCell", for: indexPath) as! FindViewCell
        
        baseButtons2.forEach { base in
            cell.bases.addButton(name: base)
        }
        flavors.forEach { flavor in
            cell.flavor.addButton(name: flavor)
        }
        
        cell.alcoholFind.addTarget(self, action: #selector(alcholFindHandler), for: .touchUpInside)
        
        colors.forEach { color in
            let view = ColorButton()
            view.colorView.backgroundColor = color
            view.clipsToBounds = true
            view.layer.cornerRadius = 8
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
    @IBOutlet weak var alcoholSlider: UISlider!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var colors: UIStackView!
    @IBOutlet weak var ingredient: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        alcoholFind.layer.cornerRadius = 5
        
        
        
//        colors.spacing = 1
    }
    
    @IBAction func sliderValueChaged(_ sender: UISlider) {
        let value = round(sender.value * 50.0)
        alcoholLabel.text = "\(value)%"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
