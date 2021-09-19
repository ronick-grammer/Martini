//
//  FindViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/20.
//

import UIKit

class FindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var flavors:[String: Cocktail.Taste] = [:]
    var baseButtons:[String: Cocktail.Alcohol] = [:]
    let colors:[Cocktail.Color:UIColor] = [.red:.systemRed, .green:.systemGreen, .blue:.systemBlue, .teal:.systemTeal, .pink:.systemPink, .orange:.systemOrange]
    let ingredients = ["Rum", "Vodka", "Gin", "Orange"]
    
//    var data:Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Cocktail.Alcohol.allCases.forEach { base in
            baseButtons[base.rawValue] = base
        }
        Cocktail.Taste.allCases.forEach { flavor in
            flavors[flavor.rawValue] = flavor
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
    
    @objc func colorButtonHandler(_ sender:ColorButton){
        print(sender)
//        guard let color = sender.cocktailColor else { return }
        let vc = initViewController("Search", identfire: "SearchView") as! SearchViewController
        vc.searchBar = false
        vc.searching = true
//        vc.searched = CocktailManager.shared.filterCocktail(color: color)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "findViewCell", for: indexPath) as! FindViewCell
        
        baseButtons.forEach { base in
            cell.bases.addButton(name: base.key)
        }
        cell.bases.delegate = self
        
        flavors.forEach { flavor in
            cell.flavor.addButton(name: flavor.key)
        }
        cell.flavor.delegate = self
        
        cell.alcoholFind.addTarget(self, action: #selector(alcholFindHandler), for: .touchUpInside)
        
        colors.forEach { color in
            let view = ColorButton()
            view.colorView.backgroundColor = color.value
            view.cocktailColor = color.key
            view.clipsToBounds = true
            view.layer.cornerRadius = 8
            view.button.addTarget(self, action: #selector(colorButtonHandler(_:)), for: .touchUpInside)
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

extension FindViewController: VStackButtonDelegate{
    func stackButtonSelected(seletedButton: UIButton, vstackButton: VStackButton) {
        guard let title = seletedButton.titleLabel?.text else {
            return
        }
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FindViewCell
        
        let vc = initViewController("Search", identfire: "SearchView") as! SearchViewController
        vc.searchBar = false
        vc.searching = true
        
        switch vstackButton {
        case cell.bases:
            vc.searched = CocktailManager.shared.filterCocktail(base: baseButtons[title]!)
            vc.navigationItem.title = "조건검색"
            self.navigationController?.pushViewController(vc, animated: true)
        case cell.flavor:
            vc.searched = CocktailManager.shared.filterCocktail(taste: flavors[title]!)
            vc.navigationItem.title = "조건검색"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
    
    
}
