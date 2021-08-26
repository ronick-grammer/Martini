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
    
    
    let strength = 20
    let ingredients = ["Vodka","Dry Vermouth","Olive"]
    let flavor = [30,20,0,0,0]
    let recipe = [["1. Add ice to the Mixer Glass"],
                  ["2. Pour Vodka, Olive Juice and Dry Vermouth into the mixer Glass"],
                  ["3. Stir together"],
                  ["4. Strain into the CockTail Glass"],
                  ["5. Garnish with Olives"]]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier) // 셀 등록
        

    }
    
    
    
    
    // 취향/재료 추천 전환
    @IBAction func switchView(_ sender: UISegmentedControl){
        
        // 취향 추천 selected
        if sender.selectedSegmentIndex == 0 {
            
        }
        
        // 재료 추천 selected
        else {
            //
        }
    }
    
    



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath)

            return cell
        }


        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainAttributeTableViewCell", for: indexPath)

            return cell
        }
        
          
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            return 414
        case 1:
            return 50
        default:
            return 50
        }
        
        
        
        
    }

    
    
   
    
    // 테이블 뷰 셋팅
}
