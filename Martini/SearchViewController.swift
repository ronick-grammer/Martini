//
//  SearchViewController.swift
//  Martini
//
//  Created by 최예주 on 2021/08/29.
//

import UIKit

// SearchView와 SettingView에서 찜한 목록 볼때쓰이는지 구분해야함
enum SearchViewType {
    case searchedList
    case likedList
}

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, CocktailTableViewCellDelegate {
    
    
    var searchBar = true
    var data:[Cocktail] = []
    
//    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var searching = false
    var searched:[Cocktail] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchViewType: SearchViewType = .searchedList // 기본값으로 searchView에서 사용하는걸로 세팅
    
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
        
        if !searching {
            CocktailManager.shared.fetchAllCocktail {
                self.data = CocktailManager.shared.cocktails
                self.tableView.reloadData()
            }
        }
        
        tableView.separatorStyle = .none
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !searching {
            switch self.searchViewType {
            case .searchedList : self.tableView.reloadData()
                CocktailManager.shared.fetchAllCocktail {
                    self.data = CocktailManager.shared.cocktails
                    self.tableView.reloadData()
                }
            case .likedList    :
                CocktailManager.shared.fetchLikedCocktails { _ in
                    self.data = CocktailManager.shared.likedCocktails
                    self.tableView.reloadData()
                }
            }
        }

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
        cell.cocktailImage.imageUrl = target.imgUrl
        
        cell.delegate = self
        cell.configure(cocktailID: target.id)
        
        return cell
    }
    
    func deleteLikedCocktail(likeButton: UIButton) {
        
        // 클릭한 좋아요 버튼의 위치를 기반으로 셀의 인덱스를 알아내기
        let point = likeButton.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: point) else { return }
        
        // ** 반드시 데이터를 먼저 제거해주고 난 뒤에 테이블 행을 없애줘야함
        self.data.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
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
