//
//  IngredientsSelectionViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/26.
//

import UIKit

class IngredientsSelectionViewController: UIViewController {
    
    @IBOutlet var ingredientsSelectionCollectionView: UICollectionView!
    @IBOutlet var btnPrev: UIButton!
    @IBOutlet var btnNext: UIButton!
    
    let identifier = "ingredientsSelectionCollectionViewCell"
    let spacingRow = 7
    let spacingColumn = 7

    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientsSelectionCollectionView.delegate = self
        ingredientsSelectionCollectionView.dataSource = self
        
        ingredientsSelectionCollectionView.register(IngredientsSelectionCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        btnPrev.layer.cornerRadius = 6
        btnPrev.titleLabel?.text = "이전"
        btnPrev.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        btnNext.layer.cornerRadius = 6
        btnNext.titleLabel?.text = "다음"
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    @IBAction func btnPreView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextView(_ sender: UIButton) {
        print("next")
    }
}


extension IngredientsSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(spacingRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(spacingColumn)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 화면에 최대 4행 4열의 셀만 보여주기
        let width = ingredientsSelectionCollectionView.bounds.width / 4 - CGFloat(spacingColumn)
        let height = ingredientsSelectionCollectionView.bounds.height / 4 - CGFloat(spacingRow)
        
        return CGSize(width: width, height: height)
    }
}


extension IngredientsSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Cocktail.Ingredients.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ingredientsSelectionCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! IngredientsSelectionCollectionViewCell
        
        if let type = Cocktail.Ingredients.init(rawValue: indexPath.row)?.type {
            let fileName = type.fileName
            let title = type.title
            
            cell.configure(fileName: fileName, title: title)
        }
        
        return cell
    }
}
