//
//  SearchViewController.swift
//  Martini
//
//  Created by 최예주 on 2021/08/29.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    
    var searchBar = true
    var data:[Cocktail] = []
    
//    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var searching = false
    var searched:[Cocktail] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 델리게이트 설정
        tableView.delegate = self
        tableView.dataSource = self
        
        // 셀 등록
        tableView.register(CockTailTableViewCell.nib, forCellReuseIdentifier: CockTailTableViewCell.identifier)
        
        
        if searchBar {
            configureSearchController()
        }
        
        CocktailManager.shared.fetchAllCocktail {
            self.data = CocktailManager.shared.cocktails
            self.tableView.reloadData()
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let target = searching ? searched[indexPath.row] : data[indexPath.row]
    
        let cell = tableView.dequeueReusableCell(withIdentifier: CockTailTableViewCell.identifier, for: indexPath) as! CockTailTableViewCell
        
        cell.nameLabel.text = target.name
        cell.descriptionLabel.text = target.description
        cell.alcoholLabel.text = "\(target.abv)%"
        let ingredientText = target.ingredients.map { $0.rawValue }
        cell.ingredientLabel.text = ingredientText.joined(separator: ", ")
        cell.tasteLabel.text = target.description
        
        return cell
        
       
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searched.count
        } else {
            return data.count
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
        searched.removeAll()
        tableView.reloadData()
    }
    
    
    // 검색결과 update
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty {
            
            searching = true
            searched.removeAll()
            for cocktail in data {
                if cocktail.name.contains(searchText) {
                    searched.append(cocktail)
                }
            }
            
        } else {
            searching = false
            searched.removeAll()
            searched = data
            
        }
        
        tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = searching ? searched[indexPath.row] : self.data[indexPath.row]
        
        let vc = initViewController("DetailView", identfire: "detailVC") as! DetailViewController
        
        vc.data = data
        vc.navigationItem.title = data.name
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
