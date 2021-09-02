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
    
    
    let recipe = ["Add ice to the Mixer Glass",
                  "Pour Vodka, Olive Juice and Dry Vermouth into the mixer Glass",
                  "Stir together",
                  "Strain into the CockTail Glass",
                  "Garnish with Olives"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier) // 셀 등록
        
        tableView.register(MainAttributeTableViewCell.nib, forCellReuseIdentifier: MainAttributeTableViewCell.identifier)
        
        tableView.register(ingredientTableViewCell.nib, forCellReuseIdentifier: ingredientTableViewCell.identifier)
        
        tableView.register(TasteTableViewCell.nib, forCellReuseIdentifier: TasteTableViewCell.identifier)
        
        tableView.register(RecipeTableViewCell.nib, forCellReuseIdentifier: RecipeTableViewCell.identifier)

        

    }
    
    
    
    
    // 취향/재료 추천 전환
    @IBAction func switchView(_ sender: UISegmentedControl){
        
        // 취향 추천 selected
        if sender.selectedSegmentIndex == 0 {
            
        }
        
        // 재료 추천 selected
        else {
            
        }
    }
    
    



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1

    }

    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        // 메인화면
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell

            
            cell.imgView.backgroundColor = UIColor(red: (232/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.5)
            cell.imgView.layer.cornerRadius = 90
                
            return cell
            
            
        // 도수 cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainAttributeTableViewCell.identifier, for: indexPath)

            return cell
            
            
        // 재료 cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ingredientTableViewCell.identifier, for: indexPath) as! ingredientTableViewCell
            
            

            if flag1 == true {
                flag1 = false
                
                cell.addLabel(name: "Orange")
                cell.addLabel(name: "Orange Orange")
                cell.addLabel(name: "Orange")
    
            }
            return cell
            
            
        // 맛 cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TasteTableViewCell.identifier, for: indexPath) as! TasteTableViewCell
                
            cell.tasteSV.translatesAutoresizingMaskIntoConstraints = false
            cell.tasteSV.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            
            if flag2 == true {
                
                flag2 = false
            
                cell.addProgress(progressbar: TasteProgressView())
                cell.addProgress(progressbar: TasteProgressView())
                cell.addProgress(progressbar: TasteProgressView())
            }
            
            return cell
            
            
        // 레시피 셀
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            
            
            if flag3 == true {
                
                flag3 = false
            
                for step in 0..<recipe.count{
                    cell.addreipe(step: step, recipe: recipe[step])
                
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
