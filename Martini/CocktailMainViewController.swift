//
//  CocktailMainViewController.swift
//  Martini
//
//  Created by 최예주 on 2021/09/19.
//

import UIKit

class CocktailMainViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var mainScrollView: UIScrollView!
    var flag1 = true
    var flag2 = true
    var flag3 = true
    
//    var tableView = UITableView()
//    var prevTableView = UITableView()
//    var nextTableView = UITableView()
   
    var data:Cocktail?
    var dataCollection:[Cocktail]?
    
    var scrollDirection:String?
    
    var selectedIndex = 1
    
//    [UICsutoView, UICsutoView, UICsutoView,]]



    var tableCollection: [UITableView]?
    
        // 이전 테이블 뷰
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.isPagingEnabled = true
        
        mainScrollView.delegate = self
        
        
//        for view in mainScrollView.subviews{
//            view.removeFromSuperview()
//        }

        
//        print("==> \(mainScrollView.subviews.map { $0.frame.minX })")
//        print(mainScrollView.subviews)
        
    
        
        CocktailManager.shared.fetchAllCocktail {
            
            self.dataCollection = CocktailManager.shared.cocktails
            
            DispatchQueue.main.async {
                for key in 0...2{
                    let tableView = CustomTableView()
                    tableView.data = CocktailManager.shared.cocktails[key]
                    
                    let xPosition = self.view.frame.width * CGFloat(key)
                    print("tableView \(key): ", tableView.frame)

                    tableView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                    
                    tableView.tableView.delegate = self
                    tableView.tableView.dataSource = self
                    
                    self.mainScrollView.contentSize.width = self.view.frame.width * CGFloat(key+1)
                    self.mainScrollView.addSubview(tableView)
                }
            }
        }
        
//        print("-->\(mainScrollView.subviews)")
        
        
        print("==> \(mainScrollView.subviews.map { $0.frame.minX })")
        
        setScrollBounds()
        
    }
    
    // scrollbound 중앙으로 설정
    func setScrollBounds(){
//        mainScrollView.contentSize.width = self.view.frame.width * CGFloat(375*4)
        mainScrollView.setContentOffset(CGPoint(x: 375, y: 0), animated: false)
        print(#function, mainScrollView.contentOffset, mainScrollView.contentSize)
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

        
        cell.imgView.backgroundColor = UIColor(red: (232/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.5)
        cell.imgView.layer.cornerRadius = 90
        
        cell.nameLabel.text = target.name
        cell.descriptionLabel.text = target.description
        
    
            
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
//            flag1 = false
            
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
            
//            flag2 = false
        
            for (taste,v) in target.taste{

                cell.addProgress(progressbar: TasteProgressView(), taste: taste.stringValue, value: (Float(v)*0.01))

            }
        }
        
        return cell
        
        
    // 레시피 셀
    case 4:
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        
        if flag3 == true {
            
//            flag3 = false
            
            for step in 0..<target.recipe.count{
                cell.addreipe(step: step, recipe: target.recipe[step])
            }
            
        }
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
        
        if offsetX == UIScreen.main.bounds.width{
            print("not Move")
           return
        }
        
        if (xPoint < offsetX) { //다음으로 간 경우
            print("go next")

            let currentView = scrollView.subviews[2] as! CustomTableView

            // 다음 뷰를 현재로 놓음
            currentView.frame = CGRect(x: self.view.frame.width * 1, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            currentView.tableView.backgroundColor = .systemRed

            // 중간 뷰를 이전 으로 놓음
            let prevView = scrollView.subviews[1] as! CustomTableView
            prevView.frame = CGRect(x: self.view.frame.width * 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
//            prevView.tableView.backgroundColor = .systemGreen

            // 추가 뷰 생성
            let newView = CustomTableView()
            newView.data = CocktailManager.shared.cocktails.first
            newView.tableView.delegate = self
            newView.tableView.dataSource = self

            newView.frame = CGRect(x: self.view.frame.width * 2, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            newView.tableView.backgroundColor = .systemBlue
            scrollView.addSubview(newView)

            scrollView.subviews[0].removeFromSuperview()
//            setScrollBounds()


        } else {  //이전으로 간 경우

            print("go prev")


            // 이전서브뷰를 현재 서브뷰로 설정
            let currentView = scrollView.subviews[0] as! CustomTableView
            currentView.frame = CGRect(x: self.view.frame.width * 1, y: 0, width: self.view.frame.width, height: self.view.frame.height)

            // 중간뷰를 다음 뷰로 설정
            let nextView = scrollView.subviews[1] as! CustomTableView
            nextView.frame = CGRect(x: self.view.frame.width * 2, y: 0, width: self.view.frame.width, height: self.view.frame.height)

            let newView = CustomTableView()
            newView.data = CocktailManager.shared.cocktails.first
            newView.tableView.delegate = self
            newView.tableView.dataSource = self
            newView.frame = CGRect(x: self.view.frame.width * 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            scrollView.insertSubview(newView, at: 0)
            scrollView.subviews[2].removeFromSuperview()
            
        }


    }
    

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: false)
    }

}
