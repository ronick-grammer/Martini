
//  DetailViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//



import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var data: Cocktail?
    

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
        
//        tableView.rowHeight = UITableView.automaticDimension

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
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
            cell.nameLabel.text = data?.name
            cell.descriptionLabel.text = data?.description
            cell.imgView.imageUrl = data?.imgUrl
            
            cell.configure(cocktailID: data?.id)
        
            return cell
        } else if indexPath.row == 1 {    // 도수 cell

            let cell = tableView.dequeueReusableCell(withIdentifier: MainAttributeTableViewCell.identifier, for: indexPath) as! MainAttributeTableViewCell

            // 도수 레이블 설정
            cell.strengthLabel.text = "\((data?.abv)!)%"

            return cell
        } else if indexPath.row == 2 {    // 재료 cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ingredientTableViewCell.identifier, for: indexPath) as! ingredientTableViewCell
            
            // 재료 label 추가
            cell.data = data?.ingredients
            
            return cell

        }
        // 맛 cell
        else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TasteTableViewCell.identifier, for: indexPath) as! TasteTableViewCell

            cell.tasteSV.translatesAutoresizingMaskIntoConstraints = false
            cell.tasteSV.heightAnchor.constraint(equalToConstant: CGFloat((data?.taste.count)! * 50)).isActive = true
            
            
            
            cell.data = data?.taste

            
            
            return cell

        } else if indexPath.row == 4 {  // 레시피 셀

            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            
            cell.data = data?.recipe

            return cell
            
        } else {
            return UITableViewCell()
        }

        
    }
    


}
