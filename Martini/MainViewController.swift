//
//  MainViewController.swift
//  Martini
//
//  Created by 최예주 on 2021/08/19.
//




import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmetedContrl: UISegmentedControl!
    
    var flag1 = true
    var flag2 = true
    var flag3 = true
    
    var data:Cocktail?
    
    let recipe = ["Add ice to the Mixer Glass",
                  "Pour Vodka, Olive Juice and Dry Vermouth into the mixer Glass",
                  "Stir together",
                  "Strain into the CockTail Glass",
                  "Garnish with Olives"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier) // 셀 등록
        
        self.tableView.register(MainAttributeTableViewCell.nib, forCellReuseIdentifier: MainAttributeTableViewCell.identifier)
        
        self.tableView.register(ingredientTableViewCell.nib, forCellReuseIdentifier: ingredientTableViewCell.identifier)
        
        self.tableView.register(TasteTableViewCell.nib, forCellReuseIdentifier: TasteTableViewCell.identifier)
        
        self.tableView.register(RecipeTableViewCell.nib, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        
        CocktailManager.shared.fetchAllCocktail {
            self.data = CocktailManager.shared.cocktails.first
            self.tableView.reloadData()
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AuthManager.shared.userSession == nil {
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    // 취향/재료 추천 전환
    @IBAction func switchView(_ sender: UISegmentedControl){
        // 취향 추천 selected
        if sender.selectedSegmentIndex == 0 {
            self.tableView.reloadData()
            
            
        }
        
        // 재료 추천 selected
        else {
            self.tableView.reloadData()
        }
    }
    
    



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1

    }

    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let target = data else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        // 메인화면
        case 0:
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell

            
            cell.imgView.backgroundColor = UIColor(red: (232/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.5)
            cell.imgView.layer.cornerRadius = 90
            
            cell.nameLabel.text = target.name
            cell.descriptionLabel.text = target.description
            // 이미지
            
                
            return cell
            
            
            
            
        // 도수 cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainAttributeTableViewCell.identifier, for: indexPath) as! MainAttributeTableViewCell
            
            cell.strengthLabel.text = "\(target.abv)%"
            return cell
            
            
        // 재료 cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ingredientTableViewCell.identifier, for: indexPath) as! ingredientTableViewCell
            
            

            if flag1 == true {
                flag1 = false
                
                for name in target.ingredients{
                    cell.addLabel(name: name.rawValue)
                }
    
            }
            return cell
            
            
        // 맛 cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TasteTableViewCell.identifier, for: indexPath) as! TasteTableViewCell
                
            cell.tasteSV.translatesAutoresizingMaskIntoConstraints = false
            cell.tasteSV.heightAnchor.constraint(equalToConstant: 250).isActive = true
            
            
            if flag2 == true {
                
                flag2 = false
            
                for (taste,v) in target.taste{
    
                    cell.addProgress(progressbar: TasteProgressView(), taste: taste.stringValue, value: (Float(v)*0.01))

                }
            }
            
            return cell
            
            
        // 레시피 셀
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            
            
            if flag3 == true {
                
                flag3 = false
                
                for step in 0..<target.recipe.count{
                    cell.addreipe(step: step, recipe: target.recipe[step])
                }
                
            }
            return cell
            
        default:
            
           
            return UITableViewCell()
        
            
      
        }
      
        
      
//        return UITableViewCell()
 
    }
    
    
    // section 5개
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.section {
//        case 0:
//            return 414
//        case 1:
//            return 50
//
//
//        }
//
//    }

    
    
   
    
    // 테이블 뷰 셋팅
}
