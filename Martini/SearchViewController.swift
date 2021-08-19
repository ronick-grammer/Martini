//
//  SearchViewController.swift
//  Martini
//
//  Created by 최예주 on 2021/08/19.
//

import UIKit


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
 
    
    // tableView
    @IBOutlet var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CockTailTableViewCell.nib, forCellReuseIdentifier: CockTailTableViewCell.identifier) // 셀 등록
        

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CockTailTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    

}
