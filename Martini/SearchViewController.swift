//
//  SearchViewController.swift
//  Martini
//
//  Created by 최예주 on 2021/08/29.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    
    

    

//    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    
    var listCocktail = [CocktailCellData]()
    var searching = false
    var searchedCocktail = [CocktailCellData]()
    
    
    let c1 = CocktailCellData(cName: "프렌치 마티니", cStrength: 20, cImage: " ", cIngredient: "Olive", cDescription: "Good....!")
    let c2 = CocktailCellData(cName: "드라이 마티니", cStrength: 20, cImage: " ", cIngredient: "Olive", cDescription: "Good....!")
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 델리게이트 설정
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // 셀 등록
        tableView.register(CockTailTableViewCell.nib, forCellReuseIdentifier: CockTailTableViewCell.identifier)
        
    
        // 임시 데이터
        listCocktail.append(c1)
        listCocktail.append(c2)
        
        configureSearchController()
        

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CockTailTableViewCell.identifier, for: indexPath) as! CockTailTableViewCell
        
       if searching
       {
        cell.nameLabel.text = searchedCocktail[indexPath.row].cocktailName
       }
        
       else {
        
        cell.nameLabel.text = listCocktail[indexPath.row].cocktailName
        
       }
        
        return cell
        
       
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return searchedCocktail.count
            
        }
        else {
            
            return listCocktail.count
        }
    }
    
    
    // searchcontroller 구현
    func configureSearchController(){
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Cocktail By Name :) "
        
    }
    
    
    // 취소버튼 눌렀을 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedCocktail.removeAll()
        tableView.reloadData()
    }
    
    
    // 검색결과 update
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty
        {
            
            searching = true
            searchedCocktail.removeAll()
            for cocktail in listCocktail
            {
                if cocktail.cocktailName.contains(searchText)
                {
                    searchedCocktail.append(cocktail)
                }
            }
            
        }
        
        else
        {
            
            searching = false
            searchedCocktail.removeAll()
            searchedCocktail=listCocktail
            
        }
        
        tableView.reloadData()
        
    }

   

}
