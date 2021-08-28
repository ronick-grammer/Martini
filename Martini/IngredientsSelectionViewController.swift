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
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let uvc = storyboard?.instantiateViewController(identifier: "flavorPreference") else { return }
        
        uvc.modalPresentationStyle = UIModalPresentationStyle.automatic
        uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    
//        self.present(uvc, animated: true)
        self.dismiss(animated: true)
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
        
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ingredientsSelectionCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! IngredientsSelectionCollectionViewCell
        
        cell.configure(fileName: ingredients[indexPath.row].imageName, title: ingredients[indexPath.row].title)
        
        return cell
    }
}

struct Ingredient {
    let imageName: String
    let title: String
}

let ingredients: [Ingredient] = [
    Ingredient(imageName: "rum", title: "럼"),
    Ingredient(imageName: "gin", title: "진"),
    Ingredient(imageName: "whisky", title: "위스키"),
    Ingredient(imageName: "tequila", title: "데킬라"),
    Ingredient(imageName: "brandy", title: "브랜디"),
    Ingredient(imageName: "vodka", title: "보드카"),
    Ingredient(imageName: "beer", title: "맥주"),
    Ingredient(imageName: "soju", title: "소주"),
    Ingredient(imageName: "champagne", title: "샴페인"),
    Ingredient(imageName: "wine", title: "와인"),
    Ingredient(imageName: "tonic", title: "토닉 워터"),
    Ingredient(imageName: "ginger ale", title: "진저 에일"),
    Ingredient(imageName: "sugar-cube", title: "설탕"),
    Ingredient(imageName: "lime-juice", title: "라임 쥬스"),
    Ingredient(imageName: "soda", title: "클럽 소다"),
    Ingredient(imageName: "mint", title: "민트"),
    Ingredient(imageName: "olives", title: "올리브"),
    Ingredient(imageName: "energy-drink", title: "에너지 드링크"),
    Ingredient(imageName: "liqueur-coffee", title: "깔루아"),
    Ingredient(imageName: "milk", title: "우유")
]
