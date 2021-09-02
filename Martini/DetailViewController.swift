//
//  DetailViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//



import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var flag1: Bool = true
    var flag2: Bool = true
    var flag3: Bool = true
    
    
    
   
    let recipe = ["Add ice to the Mixer Glass",
                  "Pour Vodka, Olive Juice and Dry Vermouth into the mixer Glass",
                  "Stir together",
                  "Strain into the CockTail Glass",
                  "Garnish with Olives"]
    

    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        tableView.delegate = self
        tableView.dataSource = self
        
        //셀등록
        tableView.register(DetailTableViewCell.nib, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        tableView.register(MainAttributeTableViewCell.nib, forCellReuseIdentifier: MainAttributeTableViewCell.identifier)
        
        tableView.register(ingredientTableViewCell.nib, forCellReuseIdentifier: ingredientTableViewCell.identifier)
        
        tableView.register(TasteTableViewCell.nib, forCellReuseIdentifier: TasteTableViewCell.identifier)
        
        tableView.register(RecipeTableViewCell.nib, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension

    
    }
    
    

   // 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell


            cell.imgView.backgroundColor = UIColor(red: (232/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.5)
            cell.imgView.layer.cornerRadius = 90

            cell.selectionStyle = .none

            
            return cell
        }
        // 도수 cell
        else if indexPath.row == 1 {


            let cell = tableView.dequeueReusableCell(withIdentifier: MainAttributeTableViewCell.identifier, for: indexPath) as! MainAttributeTableViewCell



            // 도수 레이블 설정
            cell.strengthLabel.text = "40%"
            cell.selectionStyle = .none

        
            return cell
        }
        // 재료 cell
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ingredientTableViewCell.identifier, for: indexPath) as! ingredientTableViewCell

            cell.selectionStyle = .none


            // 재료 label 추가
            
            if flag1 == true {
                
                flag1 = false
                
                cell.addLabel(name: "Orange")
                cell.addLabel(name: "Orange Orange")
                cell.addLabel(name: "Orange")
            
            }
            
            
            

            return cell

        }
        // 맛 cell
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TasteTableViewCell.identifier, for: indexPath) as! TasteTableViewCell

            cell.tasteSV.translatesAutoresizingMaskIntoConstraints = false
            cell.tasteSV.heightAnchor.constraint(equalToConstant: 150).isActive = true


            // progress bar 추가
            
            if flag2 == true {
                
            flag2 = false
            cell.addProgress(progressbar: TasteProgressView())
            cell.addProgress(progressbar: TasteProgressView())
            cell.addProgress(progressbar: TasteProgressView())

            cell.selectionStyle = .none
            }
            
            
            return cell

        }
        // 레시피 셀
        else {

            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            cell.selectionStyle = .none

            
            if flag3 == true  {
                flag3 = false
            
            // 레시피 추가
            for step in 0..<recipe.count{
                cell.addreipe(step: step, recipe: recipe[step])

                }
            }

            return cell


        }

        
    }
    


}
