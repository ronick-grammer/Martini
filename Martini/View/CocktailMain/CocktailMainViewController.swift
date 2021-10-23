
//  CocktailMainViewController.swift
//  Martini
//
//  Created by 최예주 on 2021/09/19.
//

import UIKit

class CocktailMainViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var mainScrollView: UIScrollView!

    @IBOutlet var segControll: UISegmentedControl!
    
    var data:Cocktail?
    var dataCollection:[Cocktail]?
    
    var selectedIndex = 1

    var tableCollection: [UITableView]?
    
        // 이전 테이블 뷰
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.isPagingEnabled = true
        
        mainScrollView.delegate = self
        
        CocktailManager.shared.fetchAllCocktail { [weak self] in
            
            self?.dataCollection = CocktailManager.shared.orderByTastePreference()
            
            DispatchQueue.main.async {
                self?.configureInitTable()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 최초 로그인시 맛 선호 기준으로 칵테일 정렬해서 가져오기
        if AuthManager.shared.triggerlogIn {
            self.dataCollection = CocktailManager.shared.orderByTastePreference()
            self.segControll.selectedSegmentIndex = 0
            
            DispatchQueue.main.async {
                for view in self.mainScrollView.subviews {

                    view.removeFromSuperview()

                }
                self.configureInitTable()
            }
            
            AuthManager.shared.triggerlogIn = false
        }
        
        // 다른 뷰에서 좋아요 버튼 눌러졌을때 등 상태 동기화를 위해
        mainScrollView.subviews.forEach { tableView in
            (tableView as! CustomTableView).tableView.reloadData()
        }
    }
    
    @IBAction func changeRecommend(_ sender: UISegmentedControl) {
        //취향선택을 선택했을 때
        if sender.selectedSegmentIndex == 0{
            
            
            self.dataCollection = CocktailManager.shared.orderByTastePreference()
            
            selectedIndex = 1 // 다시 처음부터
            DispatchQueue.main.async {
                for view in self.mainScrollView.subviews {
                    
                    view.removeFromSuperview()
                
                }
                self.configureInitTable()
            }
        }
        
        // 재료선택을 선택했을 때
        else{
            
            self.dataCollection = CocktailManager.shared.orderByIngredientPreference()
            
            selectedIndex = 1 // 다시 처음부터
            DispatchQueue.main.async {
                for view in self.mainScrollView.subviews {
                    
                    view.removeFromSuperview()
                
                }
                self.configureInitTable()
            }
        }
    }
    
    // scrollbound 중앙으로 설정
    func setScrollBounds(){
//        mainScrollView.contentSize.width = self.view.frame.width * CGFloat(375*4)
        mainScrollView.setContentOffset(CGPoint(x: view.frame.maxX, y: 0), animated: false)
    }
    
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 1

}


//
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let customView = tableView.superview as? CustomTableView else {
        return UITableViewCell()
    }

    guard let target = customView.data else {
        return UITableViewCell()
    }
    
    
    switch indexPath.section {
    // 메인화면
    case 0:

        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell

        cell.imgView.backgroundColor = .clear
        cell.imgView.layer.cornerRadius = 90
        
        cell.nameLabel.text = target.name
        cell.descriptionLabel.text = target.description
        cell.imgView.imageUrl = target.imgUrl
        
        cell.configure(cocktailID: target.id)
        cell.selectionStyle = .none
        
        
        return cell
        

        
    // 도수 cell
    case 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: MainAttributeTableViewCell.identifier, for: indexPath) as! MainAttributeTableViewCell
        
        cell.strengthLabel.text = "\(target.abv)%"
        cell.selectionStyle = .none
        return cell
        
        
    // 재료 cell
    case 2:
        let cell = tableView.dequeueReusableCell(withIdentifier: ingredientTableViewCell.identifier, for: indexPath) as! ingredientTableViewCell
        
        cell.data = target.ingredients
        cell.selectionStyle = .none
        
        return cell
        
        
    // 맛 cell
    case 3:
        let cell = tableView.dequeueReusableCell(withIdentifier: TasteTableViewCell.identifier, for: indexPath) as! TasteTableViewCell
            
        cell.tasteSV.translatesAutoresizingMaskIntoConstraints = false
        cell.tasteSV.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        cell.data = target.taste
        cell.selectionStyle = .none
        
        return cell
        
        
    // 레시피 셀
    case 4:
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        cell.data = target.recipe
        cell.selectionStyle = .none
        
        return cell
        
    default:
        
       
        return UITableViewCell()
    
        
  
        }
    }

    // section 5개
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    // 무한스크롤은 메모리 관리하기 편하도록
    // 항상 다음과 이전이 존재해야되고
    // 내가 현재 몇번째 데이터를 보고있는지 정보가 있어야되고
    // 현재 보고있는 데이터와 다음데이터 이전데이터가 미리 구현이 되어있어야 하고
    // 스크롤이 이동할때마다 subView에 frame들을 재설정 해줘야되고(positionX)
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity:CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let xPoint = scrollView.bounds.minX
        let offsetX = targetContentOffset.pointee.x
        
        let data = dataCollection
        
        if offsetX == UIScreen.main.bounds.width{
            
           return
        }
        
        if (xPoint < offsetX) { //다음으로 간 경우
            
            
            if selectedIndex == data!.count - 1 {
                selectedIndex = 0
            } else {
                selectedIndex += 1
            }
            
            let currentView = scrollView.subviews[2]

            // 다음 뷰를 현재로 놓음
            currentView.frame = CGRect(x: self.view.frame.width * 1, y: 0, width: self.view.frame.width, height: self.mainScrollView.frame.height)


            // 중간 뷰를 이전 으로 놓음
            let prevView = scrollView.subviews[1]
            prevView.frame = CGRect(x: self.view.frame.width * 0, y: 0, width: self.view.frame.width, height: self.mainScrollView.frame.height)
            


            // 추가 뷰 생성
            let newView = CustomTableView()
            scrollView.addSubview(newView)
            newView.tableView.delegate = self
            newView.tableView.dataSource = self
            newView.tableView.separatorStyle = .none

            newView.data = self.dataCollection![selectedIndex]
            newView.frame = CGRect(x: self.view.frame.width * 2, y: 0, width: self.view.frame.width, height: self.mainScrollView.frame.height)

            scrollView.subviews[0].removeFromSuperview()


        } else if (xPoint > offsetX) {  //이전으로 간 경우

            
            if selectedIndex == 0 {
                selectedIndex = data!.count - 1
            } else {
                selectedIndex -= 1
            }

            // 이전서브뷰를 현재 서브뷰로 설정
            let currentView = scrollView.subviews[0]
            currentView.frame = CGRect(x: self.view.frame.width * 1, y: 0, width: self.view.frame.width, height: self.mainScrollView.frame.height)

            // 중간뷰를 다음 뷰로 설정
            let nextView = scrollView.subviews[1]
            nextView.frame = CGRect(x: self.view.frame.width * 2, y: 0, width: self.view.frame.width, height: self.mainScrollView.frame.height)

            let newView = CustomTableView()
            newView.tableView.delegate = self
            newView.tableView.dataSource = self
            newView.tableView.separatorStyle = .none
            newView.data = self.dataCollection![selectedIndex]
            newView.frame = CGRect(x: self.view.frame.width * 0, y: 0, width: self.view.frame.width, height: self.mainScrollView.frame.height)
            
            scrollView.insertSubview(newView, at: 0)
            scrollView.subviews[2].removeFromSuperview()
            
        }
    }
    

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(UIScreen.main.bounds.width < scrollView.contentOffset.x){
            guard let customView = scrollView.subviews.last as? CustomTableView else {
                return
            }
            
            guard let currentView = scrollView.subviews[1] as? CustomTableView else {
                return
            }
            
            currentView.data = self.dataCollection?[selectedIndex]
            
            var newIndex = selectedIndex + 1
            
            if newIndex > dataCollection!.count - 1 {
                newIndex = 0
            }
            
            customView.data = self.dataCollection?[newIndex]
        } else {
            guard let customView = scrollView.subviews.first as? CustomTableView else {
                return
            }
            
            var newIndex = selectedIndex - 1
            
            if newIndex < 0 {
                newIndex = dataCollection!.count - 1
            }
            
            customView.data = self.dataCollection?[newIndex]
        }

        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: false)
     
    }
    
    func configureInitTable(){
        for key in 0...2{
            let tableView = CustomTableView()
            let xPosition = self.view.frame.width * CGFloat(key)

            tableView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.mainScrollView.frame.height)
            
            
            tableView.tableView.delegate = self
            tableView.tableView.dataSource = self
            
            tableView.tableView.separatorStyle = .none

            tableView.data = self.dataCollection?[key]

            self.mainScrollView.contentSize.width = self.view.frame.width * CGFloat(key+1)
            
            self.mainScrollView.addSubview(tableView)
            
            self.setScrollBounds()
            
            
            
        }
    }

}
